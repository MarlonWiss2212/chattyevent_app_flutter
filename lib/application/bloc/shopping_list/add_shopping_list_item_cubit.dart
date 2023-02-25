import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:social_media_app_flutter/application/bloc/private_event/current_private_event_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/shopping_list/shopping_list_cubit.dart';
import 'package:social_media_app_flutter/core/dto/shopping_list_item/create_shopping_list_item_dto.dart';
import 'package:social_media_app_flutter/domain/entities/error_with_title_and_message.dart';
import 'package:social_media_app_flutter/domain/entities/private_event/private_event_entity.dart';
import 'package:social_media_app_flutter/domain/entities/private_event/user_with_private_event_user_data.dart';
import 'package:social_media_app_flutter/domain/entities/shopping_list_item/shopping_list_item_entity.dart';
import 'package:social_media_app_flutter/core/failures/failures.dart';
import 'package:social_media_app_flutter/domain/usecases/shopping_list_item_usecases.dart';

part 'add_shopping_list_item_state.dart';

class AddShoppingListItemCubit extends Cubit<AddShoppingListItemState> {
  final ShoppingListItemUseCases shoppingListItemUseCases;
  final ShoppingListCubit shoppingListCubit;
  final CurrentPrivateEventCubit currentPrivateEventCubit;

  AddShoppingListItemCubit(
    super.initialState, {
    required this.shoppingListItemUseCases,
    required this.shoppingListCubit,
    required this.currentPrivateEventCubit,
  });

  Future createShoppingListItemViaApi() async {
    emitState(status: AddShoppingListItemStateStatus.loading);

    if (state.itemName == null ||
        state.amount == null ||
        state.userToBuyItemEntity == null ||
        state.selectedPrivateEvent == null) {
      return emitState(
        status: AddShoppingListItemStateStatus.error,
        error: ErrorWithTitleAndMessage(
          title: "Fehler",
          message: "Bitte fülle alle verpflichtenen Felder aus",
        ),
      );
    }

    final Either<Failure, ShoppingListItemEntity> shoppingListItemOrFailure =
        await shoppingListItemUseCases.createShoppingListItemsViaApi(
      createShoppingListItemDto: CreateShoppingListItemDto(
        itemName: state.itemName!,
        amount: state.amount!,
        userToBuyItem: state.userToBuyItemEntity!.user.id,
        unit: state.unit,
        privateEventId: state.selectedPrivateEvent!.id,
      ),
    );

    shoppingListItemOrFailure.fold(
      (error) {
        emitState(
          status: AddShoppingListItemStateStatus.error,
          error: ErrorWithTitleAndMessage(
            message: mapFailureToMessage(error),
            title: "Erstell Fehler",
          ),
        );
      },
      (shoppingListItem) {
        shoppingListCubit.mergeOrAdd(
          shoppingListItem: shoppingListItem,
        );
        emit(AddShoppingListItemState(
          status: AddShoppingListItemStateStatus.success,
          addedShoppingListItem: shoppingListItem,
        ));
      },
    );
  }

  void emitState({
    String? itemName,
    String? unit,
    double? amount,
    UserWithPrivateEventUserData? userToBuyItemEntity,
    PrivateEventEntity? selectedPrivateEvent,
    AddShoppingListItemStateStatus? status,
    ErrorWithTitleAndMessage? error,
    ShoppingListItemEntity? addedShoppingListItem,
  }) {
    emit(AddShoppingListItemState(
      itemName: itemName ?? state.itemName,
      unit: unit ?? state.unit,
      amount: amount ?? state.amount,
      userToBuyItemEntity: userToBuyItemEntity ?? state.userToBuyItemEntity,
      selectedPrivateEvent: selectedPrivateEvent ?? state.selectedPrivateEvent,
      status: status ?? AddShoppingListItemStateStatus.initial,
      error: error ?? state.error,
      addedShoppingListItem:
          addedShoppingListItem ?? state.addedShoppingListItem,
    ));
  }
}
