part of 'shopping_list_cubit.dart';

@immutable
abstract class ShoppingListState {
  final List<ShoppingListItemEntity> shoppingList;
  const ShoppingListState({
    required this.shoppingList,
  });
}

class ShoppingListInitial extends ShoppingListState {
  ShoppingListInitial() : super(shoppingList: []);
}

class ShoppingListLoading extends ShoppingListState {
  final String loadingForPrivateEventId;
  const ShoppingListLoading({
    required super.shoppingList,
    required this.loadingForPrivateEventId,
  });
}

class ShoppingListError extends ShoppingListState {
  final String loadingErrorForPrivateEventId;
  final String title;
  final String message;

  const ShoppingListError({
    required this.loadingErrorForPrivateEventId,
    required this.message,
    required this.title,
    required super.shoppingList,
  });
}

class ShoppingListLoaded extends ShoppingListState {
  const ShoppingListLoaded({required super.shoppingList});
}
