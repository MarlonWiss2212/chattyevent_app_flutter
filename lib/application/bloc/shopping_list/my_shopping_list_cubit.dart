import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:social_media_app_flutter/application/bloc/shopping_list/current_shopping_list_item_cubit.dart';
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
  }) : super(const MyShoppingListState(shoppingListItemStates: []));

  CurrentShoppingListItemState replaceOrAdd({
    required bool addIfItsNotFound,
    required CurrentShoppingListItemState shoppingListItemState,
  }) {
    int foundIndex = state.shoppingListItemStates.indexWhere(
      (element) =>
          element.shoppingListItem.id ==
          shoppingListItemState.shoppingListItem.id,
    );

    if (foundIndex != -1) {
      List<CurrentShoppingListItemState> newShoppingList =
          state.shoppingListItemStates;
      newShoppingList[foundIndex] = shoppingListItemState;
      emit(MyShoppingListState(shoppingListItemStates: newShoppingList));
      return newShoppingList[foundIndex];
    } else if (addIfItsNotFound) {
      emit(
        MyShoppingListState(
          shoppingListItemStates: List.from(state.shoppingListItemStates)
            ..add(shoppingListItemState),
        ),
      );
    }
    return shoppingListItemState;
  }

  List<CurrentShoppingListItemState> replaceOrAddMultiple({
    required bool addIfItsNotFound,
    required List<CurrentShoppingListItemState> shoppingListItemStates,
  }) {
    List<CurrentShoppingListItemState> mergedShoppingListItemStates = [];
    for (final shoppingListItemState in shoppingListItemStates) {
      final mergedShoppingListItemState = replaceOrAdd(
        addIfItsNotFound: addIfItsNotFound,
        shoppingListItemState: shoppingListItemState,
      );
      mergedShoppingListItemStates.add(mergedShoppingListItemState);
    }
    return mergedShoppingListItemStates;
  }

  void delete({required String shoppingListItemId}) {
    emit(
      MyShoppingListState(
        shoppingListItemStates: state.shoppingListItemStates
            .where(
              (element) => element.shoppingListItem.id != shoppingListItemId,
            )
            .toList(),
      ),
    );
  }

  Future getShoppingListViaApi({
    bool reload = false,
  }) async {
    emit(MyShoppingListState(
      shoppingListItemStates: state.shoppingListItemStates,
      loading: true,
    ));

    final Either<Failure, List<ShoppingListItemEntity>>
        shoppingListItemsOrFailure =
        await shoppingListItemUseCases.getShoppingListItemsViaApi(
      getShoppingListItemsFilter: GetShoppingListItemsFilter(),
      limitOffsetFilter: reload
          ? LimitOffsetFilter(
              limit: state.shoppingListItemStates.length > 20
                  ? 20
                  : state.shoppingListItemStates.length,
              offset: 0,
            )
          : LimitOffsetFilter(
              limit: 20,
              offset: state.shoppingListItemStates.length,
            ),
    );

    shoppingListItemsOrFailure.fold(
      (error) => emit(
        MyShoppingListState(
          shoppingListItemStates: state.shoppingListItemStates,
          loading: false,
          error: ErrorWithTitleAndMessage(
            message: mapFailureToMessage(error),
            title: "Lade Fehler",
          ),
        ),
      ),
      (shoppingListItems) {
        replaceOrAddMultiple(
          shoppingListItemStates: shoppingListItems
              .map(
                (e) => CurrentShoppingListItemState(
                  loadingShoppingListItem: false,
                  loadingBoughtAmounts: false,
                  shoppingListItem: e,
                  boughtAmounts: [],
                ),
              )
              .toList(),
          addIfItsNotFound: true,
        );
        MyShoppingListState(
          shoppingListItemStates: state.shoppingListItemStates,
          loading: false,
        );
      },
    );
  }
}
