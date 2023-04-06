part of 'add_shopping_list_item_cubit.dart';

enum AddShoppingListItemStateStatus { initial, loading, success }

class AddShoppingListItemState {
  final ShoppingListItemEntity? addedShoppingListItem;
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
    this.itemName,
    this.selectedPrivateEvent,
    this.unit,
    this.userToBuyItemEntity,
  });
}
