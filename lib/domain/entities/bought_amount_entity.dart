class BoughtAmountEntity {
  String id;
  DateTime? createdAt;
  DateTime? updatedAt;
  double? boughtAmount;
  String? shoppingListItemId;
  String? createdBy;

  BoughtAmountEntity({
    required this.id,
    this.createdAt,
    this.boughtAmount,
    this.shoppingListItemId,
    this.createdBy,
    this.updatedAt,
  });

  factory BoughtAmountEntity.merge({
    required BoughtAmountEntity newEntity,
    required BoughtAmountEntity oldEntity,
  }) {
    return BoughtAmountEntity(
      id: newEntity.id,
      boughtAmount: newEntity.boughtAmount ?? oldEntity.boughtAmount,
      shoppingListItemId:
          newEntity.shoppingListItemId ?? oldEntity.shoppingListItemId,
      createdBy: newEntity.createdBy ?? oldEntity.createdBy,
      createdAt: newEntity.createdAt ?? oldEntity.createdAt,
      updatedAt: newEntity.updatedAt ?? oldEntity.updatedAt,
    );
  }
}
