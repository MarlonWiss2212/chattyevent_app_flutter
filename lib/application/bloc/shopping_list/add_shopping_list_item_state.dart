part of 'add_shopping_list_item_cubit.dart';

enum AddShoppingListItemStateStatus { initial, loading, success, error }

class AddShoppingListItemState {
  final ShoppingListItemEntity? addedShoppingListItem;
  final ErrorWithTitleAndMessage? error;
  final AddShoppingListItemStateStatus status;

  // dto data
  String? itemName;
  String? unit;
  double? amount;
  UserWithPrivateEventUserData? userToBuyItemEntity;
  PrivateEventEntity? selectedPrivateEvent;

  AddShoppingListItemState({
    this.status = AddShoppingListItemStateStatus.initial,
    this.addedShoppingListItem,
    this.amount,
    this.error,
    this.itemName,
    this.selectedPrivateEvent,
    this.unit,
    this.userToBuyItemEntity,
  });
}
