import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/current_private_event/current_private_event_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/shopping_list/current_shopping_list_item_cubit.dart';
import 'package:chattyevent_app_flutter/infastructure/dto/shopping_list_item/create_shopping_list_item_dto.dart';
import 'package:chattyevent_app_flutter/domain/entities/private_event/private_event_entity.dart';
import 'package:chattyevent_app_flutter/domain/entities/private_event/private_event_user_entity.dart';
import 'package:chattyevent_app_flutter/domain/entities/shopping_list_item/shopping_list_item_entity.dart';
import 'package:chattyevent_app_flutter/domain/usecases/shopping_list_item_usecases.dart';

part 'add_shopping_list_item_state.dart';

class AddShoppingListItemCubit extends Cubit<AddShoppingListItemState> {
  final ShoppingListItemUseCases shoppingListItemUseCases;
  final CurrentPrivateEventCubit currentPrivateEventCubit;
  final NotificationCubit notificationCubit;

  AddShoppingListItemCubit(
    super.initialState, {
    required this.shoppingListItemUseCases,
    required this.currentPrivateEventCubit,
    required this.notificationCubit,
  });

  Future createShoppingListItemViaApi() async {
    if (state.itemName == null ||
        state.amount == null ||
        state.userToBuyItemEntity == null ||
        state.selectedPrivateEvent == null) {
      return notificationCubit.newAlert(
        notificationAlert: NotificationAlert(
          title: "Fehler",
          message: "Bitte fülle alle verpflichtenen Felder aus",
        ),
      );
    }
    emitState(status: AddShoppingListItemStateStatus.loading);

    final Either<NotificationAlert, ShoppingListItemEntity>
        shoppingListItemOrFailure =
        await shoppingListItemUseCases.createShoppingListItemsViaApi(
      createShoppingListItemDto: CreateShoppingListItemDto(
        itemName: state.itemName!,
        amount: state.amount!,
        userToBuyItem: state.userToBuyItemEntity!.id,
        unit: state.unit,
        privateEventTo: state.selectedPrivateEvent!.id,
      ),
    );

    shoppingListItemOrFailure.fold(
      (alert) {
        notificationCubit.newAlert(notificationAlert: alert);
        emitState(status: AddShoppingListItemStateStatus.initial);
      },
      (shoppingListItem) {
        emit(AddShoppingListItemState(
          status: AddShoppingListItemStateStatus.success,
          addedShoppingListItem: shoppingListItem,
        ));
        currentPrivateEventCubit.replaceOrAddShoppingListItem(
          addIfItsNotFound: true,
          shoppingListItemState: CurrentShoppingListItemState(
            loadingShoppingListItem: false,
            loadingBoughtAmounts: false,
            shoppingListItem: shoppingListItem,
            boughtAmounts: [],
          ),
        );
      },
    );
  }

  void emitState({
    String? itemName,
    String? unit,
    double? amount,
    PrivateEventUserEntity? userToBuyItemEntity,
    PrivateEventEntity? selectedPrivateEvent,
    AddShoppingListItemStateStatus? status,
    ShoppingListItemEntity? addedShoppingListItem,
  }) {
    emit(
      AddShoppingListItemState(
        itemName: itemName ?? state.itemName,
        unit: unit ?? state.unit,
        amount: amount ?? state.amount,
        userToBuyItemEntity: userToBuyItemEntity ?? state.userToBuyItemEntity,
        selectedPrivateEvent:
            selectedPrivateEvent ?? state.selectedPrivateEvent,
        status: status ?? AddShoppingListItemStateStatus.initial,
        addedShoppingListItem:
            addedShoppingListItem ?? state.addedShoppingListItem,
      ),
    );
  }
}
