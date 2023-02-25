part of 'shopping_list_cubit.dart';

class ShoppingListState {
  final List<ShoppingListItemEntity> shoppingList;
  final ErrorWithTitleAndMessage? error;
  final String? loadingForPrivateEventId;

  const ShoppingListState({
    required this.shoppingList,
    this.error,
    this.loadingForPrivateEventId,
  });
}
