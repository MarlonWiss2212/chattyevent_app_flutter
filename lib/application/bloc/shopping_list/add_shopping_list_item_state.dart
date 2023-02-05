part of 'add_shopping_list_item_cubit.dart';

@immutable
abstract class AddShoppingListItemState {}

class AddShoppingListItemInitial extends AddShoppingListItemState {}

class AddShoppingListItemLoading extends AddShoppingListItemState {}

class AddShoppingListItemError extends AddShoppingListItemState {
  final String title;
  final String message;

  AddShoppingListItemError({
    required this.message,
    required this.title,
  });
}

class AddShoppingListItemLoaded extends AddShoppingListItemState {
  final ShoppingListItemEntity addedShoppingListItem;

  AddShoppingListItemLoaded({
    required this.addedShoppingListItem,
  });
}
