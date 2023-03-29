import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:social_media_app_flutter/core/filter/limit_offset_filter/limit_offset_filter.dart';
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
  }) : super(const MyShoppingListState(shoppingListItems: []));

  ShoppingListItemEntity replaceOrAdd({
    required bool addIfItsNotFound,
    required ShoppingListItemEntity shoppingListItem,
  }) {
    int foundIndex = state.shoppingListItems.indexWhere(
      (element) => element.id == shoppingListItem.id,
    );

    if (foundIndex != -1) {
      List<ShoppingListItemEntity> newShoppingList = state.shoppingListItems;
      newShoppingList[foundIndex] = ShoppingListItemEntity.merge(
        newEntity: shoppingListItem,
        oldEntity: state.shoppingListItems[foundIndex],
      );
      emit(MyShoppingListState(shoppingListItems: newShoppingList));
      return newShoppingList[foundIndex];
    } else if (addIfItsNotFound) {
      emit(
        MyShoppingListState(
          shoppingListItems: List.from(state.shoppingListItems)
            ..add(shoppingListItem),
        ),
      );
    }
    return shoppingListItem;
  }

  List<ShoppingListItemEntity> replaceOrAddMultiple({
    required bool addIfItsNotFound,
    required List<ShoppingListItemEntity> shoppingListItems,
  }) {
    List<ShoppingListItemEntity> mergedShoppingList = [];
    for (final shoppingListItem in shoppingListItems) {
      final mergedShoppingListItem = replaceOrAdd(
        addIfItsNotFound: addIfItsNotFound,
        shoppingListItem: shoppingListItem,
      );
      mergedShoppingList.add(mergedShoppingListItem);
    }
    return mergedShoppingList;
  }

  void delete({required String shoppingListItemId}) {
    emit(
      MyShoppingListState(
        shoppingListItems: state.shoppingListItems
            .where(
              (element) => element.id != shoppingListItemId,
            )
            .toList(),
      ),
    );
  }

  Future getShoppingListViaApi({
    bool reload = false,
  }) async {
    emit(MyShoppingListState(
      shoppingListItems: state.shoppingListItems,
      loading: true,
    ));

    final Either<Failure, List<ShoppingListItemEntity>>
        shoppingListItemsOrFailure =
        await shoppingListItemUseCases.getShoppingListItemsViaApi(
      getShoppingListItemsFilter: GetShoppingListItemsFilter(),
      limitOffsetFilter: reload
          ? LimitOffsetFilter(
              limit: state.shoppingListItems.length > 10
                  ? 10
                  : state.shoppingListItems.length,
              offset: 0,
            )
          : LimitOffsetFilter(
              limit: 20,
              offset: state.shoppingListItems.length,
            ),
    );

    shoppingListItemsOrFailure.fold(
      (error) => emit(
        MyShoppingListState(
          shoppingListItems: state.shoppingListItems,
          loading: false,
          error: ErrorWithTitleAndMessage(
            message: mapFailureToMessage(error),
            title: "Lade Fehler",
          ),
        ),
      ),
      (shoppingListItems) {
        replaceOrAddMultiple(
          shoppingListItems: shoppingListItems,
          addIfItsNotFound: true,
        );
        MyShoppingListState(
            shoppingListItems: state.shoppingListItems, loading: false);
      },
    );
  }
}
