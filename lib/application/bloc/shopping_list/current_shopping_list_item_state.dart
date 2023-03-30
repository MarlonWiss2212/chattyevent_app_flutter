part of 'current_shopping_list_item_cubit.dart';

enum CurrentShoppingListItemStateStatus {
  initial,
  updated,
  deleted,
  error,
}

class CurrentShoppingListItemState {
  final CurrentShoppingListItemStateStatus status;

  final ShoppingListItemEntity shoppingListItem;
  final List<BoughtAmountEntity> boughtAmounts;

  final bool loadingBoughtAmounts;
  final bool loadingShoppingListItem;

  final ErrorWithTitleAndMessage? error;

  const CurrentShoppingListItemState({
    this.status = CurrentShoppingListItemStateStatus.initial,
    required this.loadingShoppingListItem,
    required this.loadingBoughtAmounts,
    required this.shoppingListItem,
    required this.boughtAmounts,
    this.error,
  });
}
