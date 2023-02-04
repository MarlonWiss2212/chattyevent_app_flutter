import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:social_media_app_flutter/domain/entities/shopping_list_item_entity.dart';
import 'package:social_media_app_flutter/domain/failures/failures.dart';
import 'package:social_media_app_flutter/domain/filter/get_shopping_list_items_filter.dart';
import 'package:social_media_app_flutter/domain/usecases/shopping_list_item_usecases.dart';

part 'current_private_event_shopping_list_state.dart';

class CurrentPrivateEventShoppingListCubit
    extends Cubit<CurrentPrivateEventShoppingListState> {
  final ShoppingListItemUseCases shoppingListItemUseCases;

  CurrentPrivateEventShoppingListCubit({
    required this.shoppingListItemUseCases,
  }) : super(CurrentPrivateEventShoppingListInitial());

  Future getShoppingListViaApi({
    required GetShoppingListItemsFilter getShoppingListItemsFilter,
  }) async {
    emit(CurrentPrivateEventShoppingListLoading());

    final Either<Failure, List<ShoppingListItemEntity>>
        shoppingListItemsOrFailure =
        await shoppingListItemUseCases.getShoppingListItemsViaApi(
      getShoppingListItemsFilter: getShoppingListItemsFilter,
    );

    shoppingListItemsOrFailure.fold(
      (error) => emit(
        CurrentPrivateEventShoppingListError(
          message: mapFailureToMessage(error),
          title: "Lade Fehler",
        ),
      ),
      (shoppingListItems) {
        emit(
          CurrentPrivateEventShoppingListLoaded(
            shoppingList: shoppingListItems,
          ),
        );
      },
    );
  }
}
