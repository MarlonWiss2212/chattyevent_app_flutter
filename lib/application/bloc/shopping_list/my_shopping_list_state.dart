part of 'my_shopping_list_cubit.dart';

class MyShoppingListState {
  final List<ShoppingListItemEntity> shoppingList;
  final ErrorWithTitleAndMessage? error;
  final bool? loading;
  final String? loadingForPrivateEventId;

  const MyShoppingListState({
    required this.shoppingList,
    this.error,
    this.loading,
    this.loadingForPrivateEventId,
  });
}
