import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:social_media_app_flutter/application/bloc/private_event/current_private_event_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/shopping_list/shopping_list_cubit.dart';
import 'package:social_media_app_flutter/domain/dto/shopping_list_item/create_shopping_list_item_dto.dart';
import 'package:social_media_app_flutter/domain/entities/shopping_list_item_entity.dart';
import 'package:social_media_app_flutter/domain/failures/failures.dart';
import 'package:social_media_app_flutter/domain/usecases/shopping_list_item_usecases.dart';

part 'add_shopping_list_item_state.dart';

class AddShoppingListItemCubit extends Cubit<AddShoppingListItemState> {
  final ShoppingListItemUseCases shoppingListItemUseCases;
  final ShoppingListCubit shoppingListCubit;
  final CurrentPrivateEventCubit currentPrivateEventCubit;

  AddShoppingListItemCubit({
    required this.shoppingListItemUseCases,
    required this.shoppingListCubit,
    required this.currentPrivateEventCubit,
  }) : super(AddShoppingListItemInitial());

  Future createShoppingListItem({
    required CreateShoppingListItemDto createShoppingListItemDto,
  }) async {
    emit(AddShoppingListItemLoading());

    final Either<Failure, ShoppingListItemEntity> shoppingListItemOrFailure =
        await shoppingListItemUseCases.createShoppingListItemsViaApi(
      createShoppingListItemDto: createShoppingListItemDto,
    );

    shoppingListItemOrFailure.fold(
      (error) {
        emit(
          AddShoppingListItemError(
            message: mapFailureToMessage(error),
            title: "Erstell Fehler",
          ),
        );
      },
      (shoppingListItem) {
        shoppingListCubit.mergeOrAdd(
          shoppingListItem: shoppingListItem,
        );
        currentPrivateEventCubit.setShoppingListFromShoppingListCubit();
        emit(AddShoppingListItemLoaded(
          addedShoppingListItem: shoppingListItem,
        ));
      },
    );
  }
}
