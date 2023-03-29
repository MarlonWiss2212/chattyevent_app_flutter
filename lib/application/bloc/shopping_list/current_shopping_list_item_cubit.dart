import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:social_media_app_flutter/application/bloc/shopping_list/my_shopping_list_cubit.dart';
import 'package:social_media_app_flutter/core/dto/bought_amount/create_bought_amount_dto.dart';
import 'package:social_media_app_flutter/core/dto/bought_amount/update_bought_amount_dto.dart';
import 'package:social_media_app_flutter/core/dto/shopping_list_item/update_shopping_list_item_dto.dart';
import 'package:social_media_app_flutter/core/failures/failures.dart';
import 'package:social_media_app_flutter/core/filter/get_one_shopping_list_item_filter.dart';
import 'package:social_media_app_flutter/domain/entities/bought_amount_entity.dart';
import 'package:social_media_app_flutter/domain/entities/error_with_title_and_message.dart';
import 'package:social_media_app_flutter/domain/entities/shopping_list_item/shopping_list_item_entity.dart';
import 'package:social_media_app_flutter/domain/usecases/bought_amount_usecases.dart';
import 'package:social_media_app_flutter/domain/usecases/shopping_list_item_usecases.dart';

part 'current_shopping_list_item_state.dart';

class CurrentShoppingListItemCubit extends Cubit<CurrentShoppingListItemState> {
  final MyShoppingListCubit shoppingListCubit;
  final ShoppingListItemUseCases shoppingListItemUseCases;
  final BoughtAmountUseCases boughtAmountUseCases;

  CurrentShoppingListItemCubit(
    super.initialState, {
    required this.boughtAmountUseCases,
    required this.shoppingListCubit,
    required this.shoppingListItemUseCases,
  });

  Future getShoppingListItemViaApi() async {
    emitState(loadingShoppingListItem: true);

    final Either<Failure, ShoppingListItemEntity> shoppingListItemOrFailure =
        await shoppingListItemUseCases.getOneShoppingListItemsViaApi(
      getOneShoppingListItemsFilter: GetOneShoppingListItemsFilter(
        id: state.shoppingListItem.id,
      ),
    );

    shoppingListItemOrFailure.fold(
      (error) {
        emitState(
          status: CurrentShoppingListItemStateStatus.error,
          error: ErrorWithTitleAndMessage(
            title: "Get Fehler",
            message: mapFailureToMessage(error),
          ),
          loadingShoppingListItem: false,
        );
      },
      (shoppingListItem) {
        emitState(
          loadingShoppingListItem: false,
          shoppingListItem: shoppingListItem,
        );
        shoppingListCubit.replaceOrAdd(shoppingListItem: shoppingListItem);
      },
    );
  }

  Future updateShoppingListItemViaApi({
    required UpdateShoppingListItemDto updateShoppingListItemDto,
  }) async {
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
        final replacedShoppingListItem = shoppingListCubit.replaceOrAdd(
          shoppingListItem: shoppingListItem,
        );
        emitState(
          shoppingListItem: replacedShoppingListItem,
          status: CurrentShoppingListItemStateStatus.updated,
        );
      },
    );
  }

  Future deleteShoppingListItemViaApi() async {
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
          emitState(status: CurrentShoppingListItemStateStatus.deleted);
          shoppingListCubit.delete(
            shoppingListItemId: state.shoppingListItem.id,
          );
        }
      },
    );
  }

  Future addBoughtAmount({
    required double boughtAmount,
  }) async {
    final Either<Failure, BoughtAmountEntity> boughtAmountOrFailure =
        await boughtAmountUseCases.createBoughtAmountViaApi(
      createBoughtAmountDto: CreateBoughtAmountDto(
        shoppingListItemId: state.shoppingListItem.id,
        boughtAmount: boughtAmount,
      ),
    );

    boughtAmountOrFailure.fold(
      (error) => emitState(
        status: CurrentShoppingListItemStateStatus.error,
        error: ErrorWithTitleAndMessage(
          title: "Create Bought Amount Error",
          message: mapFailureToMessage(error),
        ),
      ),
      (boughtAmount) {
        final newShoppingListItem = ShoppingListItemEntity.merge(
          newEntity: ShoppingListItemEntity(
            id: state.shoppingListItem.id,
            boughtAmount: state.shoppingListItem.boughtAmount != null
                ? (List.from(state.shoppingListItem.boughtAmount!)
                  ..add(boughtAmount))
                : [boughtAmount],
          ),
          oldEntity: state.shoppingListItem,
        );

        final replacedShoppingListItem = shoppingListCubit.replaceOrAdd(
          shoppingListItem: newShoppingListItem,
        );
        emitState(shoppingListItem: replacedShoppingListItem);
      },
    );
  }

  Future updateBoughtAmount({
    required UpdateBoughtAmountDto updateBoughtAmountDto,
    required String boughtAmountId,
  }) async {
    final Either<Failure, BoughtAmountEntity> boughtAmountOrFailure =
        await boughtAmountUseCases.updateBoughtAmountViaApi(
      updateBoughtAmountDto: updateBoughtAmountDto,
      boughtAmountId: boughtAmountId,
    );

    boughtAmountOrFailure.fold(
      (error) => emitState(
        status: CurrentShoppingListItemStateStatus.error,
        error: ErrorWithTitleAndMessage(
          title: "Update Bought Amount Error",
          message: mapFailureToMessage(error),
        ),
      ),
      (boughtAmount) {
        if (state.shoppingListItem.boughtAmount != null) {
          final foundIndex = state.shoppingListItem.boughtAmount!.indexWhere(
            (element) => element.id == boughtAmount.id,
          );
          if (foundIndex == -1) {
            ShoppingListItemEntity newShoppingListItem =
                ShoppingListItemEntity.merge(
              newEntity: ShoppingListItemEntity(
                id: state.shoppingListItem.id,
                boughtAmount: List.from(state.shoppingListItem.boughtAmount!)
                  ..add(boughtAmount),
              ),
              oldEntity: state.shoppingListItem,
            );

            final replacedShoppingListItem = shoppingListCubit.replaceOrAdd(
              shoppingListItem: newShoppingListItem,
            );
            emitState(shoppingListItem: replacedShoppingListItem);
          } else {
            List<BoughtAmountEntity> newBoughtAmountList =
                state.shoppingListItem.boughtAmount!;
            newBoughtAmountList[foundIndex] = boughtAmount;

            ShoppingListItemEntity newShoppingListItem =
                ShoppingListItemEntity.merge(
              newEntity: ShoppingListItemEntity(
                id: state.shoppingListItem.id,
                boughtAmount: newBoughtAmountList,
              ),
              oldEntity: state.shoppingListItem,
            );

            final replacedShoppingListItem = shoppingListCubit.replaceOrAdd(
              shoppingListItem: newShoppingListItem,
            );
            emitState(shoppingListItem: replacedShoppingListItem);
          }
        } else {
          ShoppingListItemEntity newShoppingListItem =
              ShoppingListItemEntity.merge(
            newEntity: ShoppingListItemEntity(
              id: state.shoppingListItem.id,
              boughtAmount: [boughtAmount],
            ),
            oldEntity: state.shoppingListItem,
          );
          final replacedShoppingListItem = shoppingListCubit.replaceOrAdd(
            shoppingListItem: newShoppingListItem,
          );
          emitState(shoppingListItem: replacedShoppingListItem);
        }
      },
    );
  }

  Future deleteBoughtAmount({
    required String boughtAmountId,
  }) async {
    final Either<Failure, bool> boughtAmountOrFailure =
        await boughtAmountUseCases.deleteBoughtAmountViaApi(
      boughtAmountId: boughtAmountId,
    );

    boughtAmountOrFailure.fold(
      (error) => emitState(
        status: CurrentShoppingListItemStateStatus.error,
        error: ErrorWithTitleAndMessage(
          title: "Delete Bought Amount Error",
          message: mapFailureToMessage(error),
        ),
      ),
      (deleted) {
        if (deleted) {
          if (state.shoppingListItem.boughtAmount == null) {
            final ShoppingListItemEntity newShoppingListItem =
                ShoppingListItemEntity.merge(
              newEntity: ShoppingListItemEntity(
                id: state.shoppingListItem.id,
                boughtAmount: [],
              ),
              oldEntity: state.shoppingListItem,
            );
            final replacedShoppingListItem = shoppingListCubit.replaceOrAdd(
              shoppingListItem: newShoppingListItem,
            );
            emitState(shoppingListItem: replacedShoppingListItem);
          } else {
            final ShoppingListItemEntity newShoppingListItem =
                ShoppingListItemEntity.merge(
              newEntity: ShoppingListItemEntity(
                id: state.shoppingListItem.id,
                boughtAmount: List.from(state.shoppingListItem.boughtAmount!)
                  ..removeWhere(
                    (element) => element.id == boughtAmountId,
                  ),
              ),
              oldEntity: state.shoppingListItem,
            );
            final replacedShoppingListItem = shoppingListCubit.replaceOrAdd(
              shoppingListItem: newShoppingListItem,
            );
            emitState(shoppingListItem: replacedShoppingListItem);
          }
        }
      },
    );
  }

  void emitState({
    ShoppingListItemEntity? shoppingListItem,
    bool? loadingShoppingListItem,
    CurrentShoppingListItemStateStatus? status,
    ErrorWithTitleAndMessage? error,
  }) {
    emit(CurrentShoppingListItemState(
      status: status ?? CurrentShoppingListItemStateStatus.initial,
      shoppingListItem: shoppingListItem ?? state.shoppingListItem,
      loadingShoppingListItem:
          loadingShoppingListItem ?? state.loadingShoppingListItem,
      error: error ?? state.error,
    ));
  }
}
