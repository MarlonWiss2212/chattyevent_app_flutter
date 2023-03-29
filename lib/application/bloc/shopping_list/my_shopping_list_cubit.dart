import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:social_media_app_flutter/domain/entities/error_with_title_and_message.dart';
import 'package:social_media_app_flutter/domain/entities/shopping_list_item/shopping_list_item_entity.dart';
import 'package:social_media_app_flutter/core/failures/failures.dart';
import 'package:social_media_app_flutter/core/filter/get_shopping_list_items_filter.dart';
import 'package:social_media_app_flutter/domain/usecases/shopping_list_item_usecases.dart';

part 'my_shopping_list_state.dart';

class MyShoppingListCubit extends Cubit<MyShoppingListState> {
  final ShoppingListItemUseCases shoppingListItemUseCases;

  MyShoppingListCubit({
    required this.shoppingListItemUseCases,
  }) : super(const MyShoppingListState(shoppingList: []));

  ShoppingListItemEntity replaceOrAdd({
    required ShoppingListItemEntity shoppingListItem,
  }) {
    int foundIndex = state.shoppingList.indexWhere(
      (element) => element.id == shoppingListItem.id,
    );

    if (foundIndex != -1) {
      List<ShoppingListItemEntity> newShoppingList = state.shoppingList;
      newShoppingList[foundIndex] = ShoppingListItemEntity.merge(
        newEntity: shoppingListItem,
        oldEntity: state.shoppingList[foundIndex],
      );
      emit(MyShoppingListState(shoppingList: newShoppingList));
      return newShoppingList[foundIndex];
    } else {
      emit(
        MyShoppingListState(
          shoppingList: List.from(state.shoppingList)..add(shoppingListItem),
        ),
      );
    }
    return shoppingListItem;
  }

  List<ShoppingListItemEntity> replaceOrAddMultiple({
    required List<ShoppingListItemEntity> shoppingListItems,
  }) {
    List<ShoppingListItemEntity> mergedShoppingList = [];
    for (final shoppingListItem in shoppingListItems) {
      final mergedShoppingListItem = replaceOrAdd(
        shoppingListItem: shoppingListItem,
      );
      mergedShoppingList.add(mergedShoppingListItem);
    }
    return mergedShoppingList;
  }

  void delete({required String shoppingListItemId}) {
    emit(
      MyShoppingListState(
        shoppingList: state.shoppingList
            .where(
              (element) => element.id != shoppingListItemId,
            )
            .toList(),
      ),
    );
  }

  Future getShoppingListViaApi({
    GetShoppingListItemsFilter? getShoppingListItemsFilter,
  }) async {
    emit(MyShoppingListState(
      shoppingList: state.shoppingList,
      loadingForPrivateEventId: getShoppingListItemsFilter?.privateEventId,
      loading: true,
    ));

    final Either<Failure, List<ShoppingListItemEntity>>
        shoppingListItemsOrFailure =
        await shoppingListItemUseCases.getShoppingListItemsViaApi(
      getShoppingListItemsFilter: getShoppingListItemsFilter,
    );

    shoppingListItemsOrFailure.fold(
      (error) => emit(
        MyShoppingListState(
          shoppingList: state.shoppingList,
          loading: false,
          error: ErrorWithTitleAndMessage(
            message: mapFailureToMessage(error),
            title: "Lade Fehler",
          ),
        ),
      ),
      (shoppingListItems) {
        replaceOrAddMultiple(shoppingListItems: shoppingListItems);
        // too set loading false
        MyShoppingListState(shoppingList: state.shoppingList, loading: false);
      },
    );
  }
}
