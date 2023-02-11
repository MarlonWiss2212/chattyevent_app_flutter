class ShoppingListItemEntity {
  String id;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? itemName;
  String? unit;
  double? amount;
  double? boughtAmount;
  String? userToBuyItem;
  String? privateEventId;
  String? createdBy;

  ShoppingListItemEntity({
    required this.id,
    this.createdAt,
    this.amount,
    this.boughtAmount,
    this.itemName,
    this.privateEventId,
    this.unit,
    this.createdBy,
    this.updatedAt,
    this.userToBuyItem,
  });

  factory ShoppingListItemEntity.merge({
    required ShoppingListItemEntity newEntity,
    required ShoppingListItemEntity oldEntity,
  }) {
    return ShoppingListItemEntity(
      id: newEntity.id,
      itemName: newEntity.itemName ?? oldEntity.itemName,
      unit: newEntity.unit ?? oldEntity.unit,
      amount: newEntity.amount ?? oldEntity.amount,
      boughtAmount: newEntity.boughtAmount ?? oldEntity.boughtAmount,
      userToBuyItem: newEntity.userToBuyItem ?? oldEntity.userToBuyItem,
      privateEventId: newEntity.privateEventId ?? oldEntity.privateEventId,
      createdBy: newEntity.createdBy ?? oldEntity.createdBy,
      createdAt: newEntity.createdAt ?? oldEntity.createdAt,
      updatedAt: newEntity.updatedAt ?? oldEntity.updatedAt,
    );
  }
}
