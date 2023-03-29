part of 'my_shopping_list_cubit.dart';

class MyShoppingListState {
  final List<ShoppingListItemEntity> shoppingListItems;
  final ErrorWithTitleAndMessage? error;
  final bool? loading;

  const MyShoppingListState({
    required this.shoppingListItems,
    this.error,
    this.loading,
  });
}
