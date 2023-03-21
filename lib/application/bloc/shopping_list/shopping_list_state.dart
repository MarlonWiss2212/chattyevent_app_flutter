part of 'shopping_list_cubit.dart';

class ShoppingListState {
  final List<ShoppingListItemEntity> shoppingList;
  final ErrorWithTitleAndMessage? error;
  final bool? loading;
  final String? loadingForPrivateEventId;

  const ShoppingListState({
    required this.shoppingList,
    this.error,
    this.loading,
    this.loadingForPrivateEventId,
  });
}
