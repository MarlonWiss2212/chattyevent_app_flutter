import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/shopping_list/current_shopping_list_item_cubit.dart';
import 'package:chattyevent_app_flutter/infastructure/filter/limit_offset_filter.dart';
import 'package:chattyevent_app_flutter/infastructure/filter/shopping_list_item/find_shopping_list_items_filter.dart';
import 'package:chattyevent_app_flutter/domain/entities/shopping_list_item/shopping_list_item_entity.dart';
import 'package:chattyevent_app_flutter/domain/usecases/shopping_list_item_usecases.dart';

part 'my_shopping_list_state.dart';

class MyShoppingListCubit extends Cubit<MyShoppingListState> {
  final ShoppingListItemUseCases shoppingListItemUseCases;
  final NotificationCubit notificationCubit;

  MyShoppingListCubit({
    required this.shoppingListItemUseCases,
    required this.notificationCubit,
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
          shoppingListItemStates: List.from([shoppingListItemState])
            ..addAll(
              state.shoppingListItemStates,
            ),
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

    final Either<NotificationAlert, List<ShoppingListItemEntity>>
        shoppingListItemsOrFailure =
        await shoppingListItemUseCases.getShoppingListItemsViaApi(
      findShoppingListItemsFilter: FindShoppingListItemsFilter(),
      limitOffsetFilter: reload
          ? LimitOffsetFilter(
              limit: state.shoppingListItemStates.length < 20
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
      (alert) {
        notificationCubit.newAlert(notificationAlert: alert);
        emit(
          MyShoppingListState(
            shoppingListItemStates: state.shoppingListItemStates,
            loading: false,
          ),
        );
      },
      (shoppingListItems) {
        if (reload) {
          emit(MyShoppingListState(
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
            loading: false,
          ));
        } else {
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
          emit(MyShoppingListState(
            shoppingListItemStates: state.shoppingListItemStates,
            loading: false,
          ));
        }
      },
    );
  }
}
