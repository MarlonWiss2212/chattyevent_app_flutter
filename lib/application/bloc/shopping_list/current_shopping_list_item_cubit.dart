import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:social_media_app_flutter/application/bloc/private_event/current_private_event_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/shopping_list/my_shopping_list_cubit.dart';
import 'package:social_media_app_flutter/core/dto/bought_amount/create_bought_amount_dto.dart';
import 'package:social_media_app_flutter/core/dto/bought_amount/update_bought_amount_dto.dart';
import 'package:social_media_app_flutter/core/dto/shopping_list_item/update_shopping_list_item_dto.dart';
import 'package:social_media_app_flutter/core/failures/failures.dart';
import 'package:social_media_app_flutter/core/filter/get_bought_amounts_filter.dart';
import 'package:social_media_app_flutter/core/filter/get_one_shopping_list_item_filter.dart';
import 'package:social_media_app_flutter/core/filter/limit_offset_filter/limit_offset_filter.dart';
import 'package:social_media_app_flutter/domain/entities/bought_amount_entity.dart';
import 'package:social_media_app_flutter/domain/entities/error_with_title_and_message.dart';
import 'package:social_media_app_flutter/domain/entities/shopping_list_item/shopping_list_item_entity.dart';
import 'package:social_media_app_flutter/domain/usecases/bought_amount_usecases.dart';
import 'package:social_media_app_flutter/domain/usecases/shopping_list_item_usecases.dart';

part 'current_shopping_list_item_state.dart';

class CurrentShoppingListItemCubit extends Cubit<CurrentShoppingListItemState> {
  /// to replace shopping list items
  final Either<MyShoppingListCubit, CurrentPrivateEventCubit>
      shoppingListCubitOrPrivateEventCubit;

  /// in future save current private event in this cubit

  final ShoppingListItemUseCases shoppingListItemUseCases;
  final BoughtAmountUseCases boughtAmountUseCases;

  CurrentShoppingListItemCubit(
    super.initialState, {
    required this.boughtAmountUseCases,
    required this.shoppingListCubitOrPrivateEventCubit,
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

  Future getBoughtAmounts({
    bool reload = false,
  }) async {
    emitState(loadingBoughtAmounts: true);
    final Either<Failure, List<BoughtAmountEntity>> boughtAmountOrFailure =
        await boughtAmountUseCases.getBoughtAmountsViaApi(
      getBoughtAmountsFilter: GetBoughtAmountsFilter(
        shoppingListItemIds: [state.shoppingListItem.id],
      ),
      limitOffsetFilter: LimitOffsetFilter(
        limit: reload
            ? state.boughtAmounts.length > 20
                ? state.boughtAmounts.length
                : 20
            : 20,
        offset: reload ? 0 : state.boughtAmounts.length,
      ),
    );

    boughtAmountOrFailure.fold(
      (error) => emitState(
        status: CurrentShoppingListItemStateStatus.error,
        error: ErrorWithTitleAndMessage(
          title: "Get Bought Amounts Error",
          message: mapFailureToMessage(error),
        ),
        loadingBoughtAmounts: false,
      ),
      (boughtAmounts) {
        List<BoughtAmountEntity> newBoughtAmounts =
            reload ? boughtAmounts : List.from(state.boughtAmounts)
              ..addAll(boughtAmounts);

        emitState(
          boughtAmounts: newBoughtAmounts,
          loadingBoughtAmounts: false,
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
        emitState(
          boughtAmounts: List.from([boughtAmount])..addAll(state.boughtAmounts),
          shoppingListItem: ShoppingListItemEntity.merge(
            newEntity: ShoppingListItemEntity(
              id: state.shoppingListItem.id,
              boughtAmount: state.boughtAmounts
                  .map((e) => e.boughtAmount!)
                  .reduce((a, b) => a + b),
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
        final newBoughtAmountList = state.boughtAmounts
            .where((element) => element.id != boughtAmount.id)
            .toList();
        newBoughtAmountList.add(boughtAmount);
        emitState(
          boughtAmounts: (newBoughtAmountList),
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
          emitState(
            boughtAmounts: state.boughtAmounts
                .where((element) => element.id != boughtAmountId)
                .toList(),
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
    bool? loadingShoppingListItem,
    bool? loadingBoughtAmounts,
    CurrentShoppingListItemStateStatus? status,
    ErrorWithTitleAndMessage? error,
    List<BoughtAmountEntity>? boughtAmounts,
  }) {
    emit(CurrentShoppingListItemState(
      status: status ?? CurrentShoppingListItemStateStatus.initial,
      boughtAmounts: boughtAmounts ?? state.boughtAmounts,
      shoppingListItem: shoppingListItem ?? state.shoppingListItem,
      loadingBoughtAmounts: loadingBoughtAmounts ?? state.loadingBoughtAmounts,
      loadingShoppingListItem:
          loadingShoppingListItem ?? state.loadingShoppingListItem,
      error: error ?? state.error,
    ));
  }
}
