import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:social_media_app_flutter/domain/entities/error_with_title_and_message.dart';
import 'package:social_media_app_flutter/domain/entities/shopping_list_item/shopping_list_item_entity.dart';
import 'package:social_media_app_flutter/core/failures/failures.dart';
import 'package:social_media_app_flutter/core/filter/get_shopping_list_items_filter.dart';
import 'package:social_media_app_flutter/domain/usecases/shopping_list_item_usecases.dart';

part 'shopping_list_state.dart';

class ShoppingListCubit extends Cubit<ShoppingListState> {
  final ShoppingListItemUseCases shoppingListItemUseCases;

  ShoppingListCubit({
    required this.shoppingListItemUseCases,
  }) : super(const ShoppingListState(shoppingList: []));

  ShoppingListItemEntity mergeOrAdd({
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
      emit(ShoppingListState(shoppingList: newShoppingList));
      return newShoppingList[foundIndex];
    } else {
      emit(
        ShoppingListState(
          shoppingList: List.from(state.shoppingList)..add(shoppingListItem),
        ),
      );
    }
    return shoppingListItem;
  }

  List<ShoppingListItemEntity> mergeOrAddMultiple({
    required List<ShoppingListItemEntity> shoppingListItems,
  }) {
    List<ShoppingListItemEntity> mergedShoppingList = [];
    for (final shoppingListItem in shoppingListItems) {
      // state will be changed in mergeOrAdd
      final mergedShoppingListItem = mergeOrAdd(
        shoppingListItem: shoppingListItem,
      );
      mergedShoppingList.add(mergedShoppingListItem);
    }
    return mergedShoppingList;
  }

  void delete({required String shoppingListItemId}) {
    emit(
      ShoppingListState(
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
    emit(ShoppingListState(
      shoppingList: state.shoppingList,
      loadingForPrivateEventId: getShoppingListItemsFilter?.privateEventId,
    ));

    final Either<Failure, List<ShoppingListItemEntity>>
        shoppingListItemsOrFailure =
        await shoppingListItemUseCases.getShoppingListItemsViaApi(
      getShoppingListItemsFilter: getShoppingListItemsFilter,
    );

    shoppingListItemsOrFailure.fold(
      (error) => emit(
        ShoppingListState(
          shoppingList: state.shoppingList,
          error: ErrorWithTitleAndMessage(
            message: mapFailureToMessage(error),
            title: "Lade Fehler",
          ),
        ),
      ),
      (shoppingListItems) {
        mergeOrAddMultiple(
          shoppingListItems: shoppingListItems,
        );
      },
    );
  }
}
