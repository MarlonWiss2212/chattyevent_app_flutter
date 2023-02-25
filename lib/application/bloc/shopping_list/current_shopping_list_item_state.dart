part of 'current_shopping_list_item_cubit.dart';

enum CurrentShoppingListItemStateStatus {
  initial,
  loading,
  success,
  sucessDelete,
  successUpdate,
  error
}

class CurrentShoppingListItemState {
  final ShoppingListItemEntity shoppingListItem;
  final ErrorWithTitleAndMessage? error;
  final CurrentShoppingListItemStateStatus status;

  const CurrentShoppingListItemState({
    this.error,
    this.status = CurrentShoppingListItemStateStatus.initial,
    required this.shoppingListItem,
  });
}
