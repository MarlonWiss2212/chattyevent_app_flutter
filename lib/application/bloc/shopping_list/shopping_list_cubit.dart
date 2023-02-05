import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:social_media_app_flutter/domain/entities/shopping_list_item_entity.dart';
import 'package:social_media_app_flutter/domain/failures/failures.dart';
import 'package:social_media_app_flutter/domain/filter/get_shopping_list_items_filter.dart';
import 'package:social_media_app_flutter/domain/usecases/shopping_list_item_usecases.dart';

part 'shopping_list_state.dart';

class ShoppingListCubit extends Cubit<ShoppingListState> {
  final ShoppingListItemUseCases shoppingListItemUseCases;

  ShoppingListCubit({
    required this.shoppingListItemUseCases,
  }) : super(ShoppingListInitial());

  void addItem({required ShoppingListItemEntity shoppingListItem}) {
    if (state is ShoppingListLoaded) {
      final state = this.state as ShoppingListLoaded;
      emit(
        ShoppingListLoaded(
          shoppingList: List.from(state.shoppingList)..add(shoppingListItem),
        ),
      );
    } else {
      emit(
        ShoppingListLoaded(
          shoppingList: [shoppingListItem],
        ),
      );
    }
  }

  Future getShoppingListViaApi({
    required GetShoppingListItemsFilter getShoppingListItemsFilter,
  }) async {
    emit(ShoppingListLoading(
      shoppingList: state.shoppingList,
      loadingForPrivateEventId: getShoppingListItemsFilter.privateEvent,
    ));

    final Either<Failure, List<ShoppingListItemEntity>>
        shoppingListItemsOrFailure =
        await shoppingListItemUseCases.getShoppingListItemsViaApi(
      getShoppingListItemsFilter: getShoppingListItemsFilter,
    );

    shoppingListItemsOrFailure.fold(
      (error) => emit(
        ShoppingListError(
          loadingErrorForPrivateEventId:
              getShoppingListItemsFilter.privateEvent,
          shoppingList: state.shoppingList,
          message: mapFailureToMessage(error),
          title: "Lade Fehler",
        ),
      ),
      (shoppingListItems) {
        List<ShoppingListItemEntity> shoppingListItemsToEmit =
            shoppingListItems;

        for (final item in state.shoppingList) {
          bool savedTheItem = false;

          innerLoop:
          for (final shoppingListItemToEmit in shoppingListItemsToEmit) {
            if (shoppingListItemToEmit.id == item.id) {
              savedTheItem = true;
              break innerLoop;
            }
          }

          if (!savedTheItem) {
            shoppingListItemsToEmit.add(item);
          }
        }

        emit(
          ShoppingListLoaded(
            shoppingList: shoppingListItemsToEmit,
          ),
        );
      },
    );
  }
}
