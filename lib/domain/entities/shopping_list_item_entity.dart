class ShoppingListItemEntity {
  String id;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? itemName;
  String? unit;
  double? amount;
  double? boughtAmount;
  String? userToBuyItem;
  String? privateEvent;

  ShoppingListItemEntity({
    required this.id,
    this.createdAt,
    this.amount,
    this.boughtAmount,
    this.itemName,
    this.privateEvent,
    this.unit,
    this.updatedAt,
    this.userToBuyItem,
  });
}
