import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/current_event/current_event_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/shopping_list/my_shopping_list_cubit.dart';
import 'package:chattyevent_app_flutter/infastructure/dto/shopping_list_item/bought_amount/create_bought_amount_dto.dart';
import 'package:chattyevent_app_flutter/infastructure/dto/shopping_list_item/bought_amount/update_bought_amount_dto.dart';
import 'package:chattyevent_app_flutter/infastructure/dto/shopping_list_item/update_shopping_list_item_dto.dart';
import 'package:chattyevent_app_flutter/infastructure/filter/shopping_list_item/bought_amount/find_one_bought_amount_filter.dart';
import 'package:chattyevent_app_flutter/infastructure/filter/shopping_list_item/find_one_shopping_list_item_filter.dart';
import 'package:chattyevent_app_flutter/domain/entities/bought_amount_entity.dart';
import 'package:chattyevent_app_flutter/domain/entities/shopping_list_item/shopping_list_item_entity.dart';
import 'package:chattyevent_app_flutter/domain/usecases/bought_amount_usecases.dart';
import 'package:chattyevent_app_flutter/domain/usecases/shopping_list_item_usecases.dart';

part 'current_shopping_list_item_state.dart';

class CurrentShoppingListItemCubit extends Cubit<CurrentShoppingListItemState> {
  final NotificationCubit notificationCubit;
  final Either<MyShoppingListCubit, CurrentEventCubit>
      shoppingListCubitOrPrivateEventCubit;

  final ShoppingListItemUseCases shoppingListItemUseCases;
  final BoughtAmountUseCases boughtAmountUseCases;

  CurrentShoppingListItemCubit(
    super.initialState, {
    required this.notificationCubit,
    required this.boughtAmountUseCases,
    required this.shoppingListCubitOrPrivateEventCubit,
    required this.shoppingListItemUseCases,
  });

  Future getShoppingListItemViaApi() async {
    emitState(loading: true);

    final Either<NotificationAlert, ShoppingListItemEntity>
        shoppingListItemOrFailure =
        await shoppingListItemUseCases.getOneShoppingListItemsViaApi(
            findOneShoppingListItemFilter: FindOneShoppingListItemFilter(
      shoppingListItemTo: state.shoppingListItem.id,
    ));

    shoppingListItemOrFailure.fold(
      (alert) {
        notificationCubit.newAlert(notificationAlert: alert);
        emitState(loading: false);
      },
      (shoppingListItem) {
        emitState(
          loading: false,
          shoppingListItem: shoppingListItem,
        );
        shoppingListCubitOrPrivateEventCubit.fold(
          (l) => l.replaceOrAdd(
            addIfItsNotFound: false,
            shoppingListItemState: state,
          ),
          (r) => r.replaceOrAddShoppingListItem(
            addIfItsNotFound: false,
            shoppingListItemState: state,
          ),
        );
      },
    );
  }

  Future updateShoppingListItemViaApi({
    required UpdateShoppingListItemDto updateShoppingListItemDto,
  }) async {
    final Either<NotificationAlert, ShoppingListItemEntity>
        shoppingListItemOrFailure =
        await shoppingListItemUseCases.updateShoppingListItemsViaApi(
      updateShoppingListItemDto: updateShoppingListItemDto,
      findOneShoppingListItemFilter: FindOneShoppingListItemFilter(
        shoppingListItemTo: state.shoppingListItem.id,
      ),
    );

    shoppingListItemOrFailure.fold(
      (alert) => notificationCubit.newAlert(notificationAlert: alert),
      (shoppingListItem) {
        emitState(
          shoppingListItem: shoppingListItem,
          status: CurrentShoppingListItemStateStatus.updated,
        );

        shoppingListCubitOrPrivateEventCubit.fold(
          (l) => l.replaceOrAdd(
            addIfItsNotFound: false,
            shoppingListItemState: state,
          ),
          (r) => r.replaceOrAddShoppingListItem(
            addIfItsNotFound: false,
            shoppingListItemState: state,
          ),
        );
      },
    );
  }

  Future deleteShoppingListItemViaApi() async {
    final Either<NotificationAlert, bool> deletedOrFailure =
        await shoppingListItemUseCases.deleteShoppingListItemViaApi(
      findOneShoppingListItemFilter: FindOneShoppingListItemFilter(
        shoppingListItemTo: state.shoppingListItem.id,
      ),
    );

    deletedOrFailure.fold(
      (alert) => notificationCubit.newAlert(notificationAlert: alert),
      (deleted) {
        if (deleted) {
          emitState(status: CurrentShoppingListItemStateStatus.deleted);

          shoppingListCubitOrPrivateEventCubit.fold(
            (l) => l.delete(
              shoppingListItemId: state.shoppingListItem.id,
            ),
            (r) => r.deleteShoppingListItem(
              shoppingListItemId: state.shoppingListItem.id,
            ),
          );
        }
      },
    );
  }

  Future addBoughtAmount({required double boughtAmount}) async {
    final Either<NotificationAlert, BoughtAmountEntity> boughtAmountOrFailure =
        await boughtAmountUseCases.createBoughtAmountViaApi(
      createBoughtAmountDto: CreateBoughtAmountDto(
        shoppingListItemTo: state.shoppingListItem.id,
        boughtAmount: boughtAmount,
      ),
    );

    boughtAmountOrFailure.fold(
      (alert) => notificationCubit.newAlert(notificationAlert: alert),
      (boughtAmountEntity) {
        final List<BoughtAmountEntity> newBoughtAmounts = [
          boughtAmountEntity,
          if (state.shoppingListItem.boughtAmounts != null) ...{
            ...state.shoppingListItem.boughtAmounts!,
          }
        ];

        emitState(
          shoppingListItem: ShoppingListItemEntity.merge(
            newEntity: ShoppingListItemEntity(
                id: state.shoppingListItem.id, boughtAmounts: newBoughtAmounts),
            oldEntity: state.shoppingListItem,
          ),
        );
        shoppingListCubitOrPrivateEventCubit.fold(
          (l) => l.replaceOrAdd(
            addIfItsNotFound: false,
            shoppingListItemState: state,
          ),
          (r) => r.replaceOrAddShoppingListItem(
            addIfItsNotFound: false,
            shoppingListItemState: state,
          ),
        );
      },
    );
  }

  Future updateBoughtAmount({
    required UpdateBoughtAmountDto updateBoughtAmountDto,
    required String boughtAmountId,
  }) async {
    final Either<NotificationAlert, BoughtAmountEntity> boughtAmountOrFailure =
        await boughtAmountUseCases.updateBoughtAmountViaApi(
      updateBoughtAmountDto: updateBoughtAmountDto,
      findOneBoughtAmountFilter: FindOneBoughtAmountFilter(
        boughtAmountId: boughtAmountId,
      ),
    );

    boughtAmountOrFailure.fold(
      (alert) => notificationCubit.newAlert(notificationAlert: alert),
      (boughtAmount) {
        final newBoughtAmountList = state.shoppingListItem.boughtAmounts
                ?.where((element) => element.id != boughtAmount.id)
                .toList() ??
            [];
        newBoughtAmountList.add(boughtAmount);
        emitState(
          shoppingListItem: ShoppingListItemEntity.merge(
            newEntity: ShoppingListItemEntity(
              id: state.shoppingListItem.id,
              boughtAmounts: newBoughtAmountList,
            ),
            oldEntity: state.shoppingListItem,
          ),
        );
        shoppingListCubitOrPrivateEventCubit.fold(
          (l) => l.replaceOrAdd(
            addIfItsNotFound: false,
            shoppingListItemState: state,
          ),
          (r) => r.replaceOrAddShoppingListItem(
            addIfItsNotFound: false,
            shoppingListItemState: state,
          ),
        );
      },
    );
  }

  Future deleteBoughtAmount({
    required String boughtAmountId,
  }) async {
    final Either<NotificationAlert, bool> boughtAmountOrFailure =
        await boughtAmountUseCases.deleteBoughtAmountViaApi(
      findOneBoughtAmountFilter: FindOneBoughtAmountFilter(
        boughtAmountId: boughtAmountId,
      ),
    );

    boughtAmountOrFailure.fold(
      (alert) => notificationCubit.newAlert(notificationAlert: alert),
      (deleted) {
        if (deleted) {
          final newBoughtAmounts = state.shoppingListItem.boughtAmounts
              ?.where((element) => element.id != boughtAmountId)
              .toList();
          emitState(
            shoppingListItem: ShoppingListItemEntity.merge(
              newEntity: ShoppingListItemEntity(
                id: state.shoppingListItem.id,
                boughtAmounts: newBoughtAmounts,
              ),
              oldEntity: state.shoppingListItem,
            ),
          );
          shoppingListCubitOrPrivateEventCubit.fold(
            (l) => l.replaceOrAdd(
              addIfItsNotFound: false,
              shoppingListItemState: state,
            ),
            (r) => r.replaceOrAddShoppingListItem(
              addIfItsNotFound: false,
              shoppingListItemState: state,
            ),
          );
        }
      },
    );
  }

  void emitState({
    ShoppingListItemEntity? shoppingListItem,
    bool? loading,
    CurrentShoppingListItemStateStatus? status,
  }) {
    emit(CurrentShoppingListItemState(
      status: status ?? CurrentShoppingListItemStateStatus.initial,
      shoppingListItem: shoppingListItem ?? state.shoppingListItem,
      loading: loading ?? state.loading,
    ));
  }
}
