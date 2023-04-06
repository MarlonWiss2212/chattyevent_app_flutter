part of 'my_shopping_list_cubit.dart';

class MyShoppingListState {
  final List<CurrentShoppingListItemState> shoppingListItemStates;
  final bool? loading;

  const MyShoppingListState({
    required this.shoppingListItemStates,
    this.loading,
  });
}
