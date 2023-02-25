import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:social_media_app_flutter/application/bloc/shopping_list/shopping_list_cubit.dart';
import 'package:social_media_app_flutter/core/dto/shopping_list_item/update_shopping_list_item_dto.dart';
import 'package:social_media_app_flutter/core/failures/failures.dart';
import 'package:social_media_app_flutter/core/filter/get_one_shopping_list_item_filter.dart';
import 'package:social_media_app_flutter/domain/entities/error_with_title_and_message.dart';
import 'package:social_media_app_flutter/domain/entities/shopping_list_item/shopping_list_item_entity.dart';
import 'package:social_media_app_flutter/domain/usecases/shopping_list_item_usecases.dart';

part 'current_shopping_list_item_state.dart';

class CurrentShoppingListItemCubit extends Cubit<CurrentShoppingListItemState> {
  final ShoppingListCubit shoppingListCubit;
  final ShoppingListItemUseCases shoppingListItemUseCases;

  CurrentShoppingListItemCubit(
    super.initialState, {
    required this.shoppingListCubit,
    required this.shoppingListItemUseCases,
  });

  Future getShoppingListItemViaApi() async {
    emitState(status: CurrentShoppingListItemStateStatus.loading);

    final Either<Failure, ShoppingListItemEntity> shoppingListItemOrFailure =
        await shoppingListItemUseCases.getOneShoppingListItemsViaApi(
      getOneShoppingListItemsFilter:
          GetOneShoppingListItemsFilter(id: state.shoppingListItem.id),
    );

    shoppingListItemOrFailure.fold(
      (error) {
        emitState(
          status: CurrentShoppingListItemStateStatus.error,
          error: ErrorWithTitleAndMessage(
            title: "Get Fehler",
            message: mapFailureToMessage(error),
          ),
        );
      },
      (shoppingListItem) {
        emitState(
          shoppingListItem: shoppingListItem,
          status: CurrentShoppingListItemStateStatus.success,
        );
        shoppingListCubit.mergeOrAdd(shoppingListItem: shoppingListItem);
      },
    );
  }

  Future updateShoppingListItemViaApi({
    required UpdateShoppingListItemDto updateShoppingListItemDto,
  }) async {
    emitState(status: CurrentShoppingListItemStateStatus.loading);

    final Either<Failure, ShoppingListItemEntity> shoppingListItemOrFailure =
        await shoppingListItemUseCases.updateShoppingListItemsViaApi(
      updateShoppingListItemDto: updateShoppingListItemDto,
      shoppingListItemId: state.shoppingListItem.id,
    );

    shoppingListItemOrFailure.fold(
      (error) {
        emitState(
          status: CurrentShoppingListItemStateStatus.error,
          error: ErrorWithTitleAndMessage(
            title: "Update Fehler",
            message: mapFailureToMessage(error),
          ),
        );
      },
      (shoppingListItem) {
        emitState(
          shoppingListItem: shoppingListItem,
          status: CurrentShoppingListItemStateStatus.successUpdate,
        );
        shoppingListCubit.mergeOrAdd(shoppingListItem: shoppingListItem);
      },
    );
  }

  Future deleteShoppingListItemViaApi() async {
    emitState(status: CurrentShoppingListItemStateStatus.loading);

    final Either<Failure, bool> deletedOrFailure =
        await shoppingListItemUseCases.deleteShoppingListItemViaApi(
      shoppingListItemId: state.shoppingListItem.id,
    );

    deletedOrFailure.fold(
      (error) {
        emitState(
          status: CurrentShoppingListItemStateStatus.error,
          error: ErrorWithTitleAndMessage(
            title: "Delete Fehler",
            message: mapFailureToMessage(error),
          ),
        );
      },
      (deleted) {
        if (deleted) {
          emitState(status: CurrentShoppingListItemStateStatus.sucessDelete);
          shoppingListCubit.delete(
            shoppingListItemId: state.shoppingListItem.id,
          );
        }
      },
    );
  }

  void emitState({
    ShoppingListItemEntity? shoppingListItem,
    CurrentShoppingListItemStateStatus? status,
    ErrorWithTitleAndMessage? error,
  }) {
    emit(
      CurrentShoppingListItemState(
        status: status ?? CurrentShoppingListItemStateStatus.initial,
        shoppingListItem: shoppingListItem ?? state.shoppingListItem,
        error: error ?? state.error,
      ),
    );
  }
}
