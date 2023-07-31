part of 'current_shopping_list_item_cubit.dart';

enum CurrentShoppingListItemStateStatus {
  initial,
  updated,
  deleted,
}

class CurrentShoppingListItemState {
  final CurrentShoppingListItemStateStatus status;
  final ShoppingListItemEntity shoppingListItem;
  final bool loading;

  const CurrentShoppingListItemState({
    this.status = CurrentShoppingListItemStateStatus.initial,
    required this.loading,
    required this.shoppingListItem,
  });
}
