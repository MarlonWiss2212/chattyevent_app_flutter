class BoughtAmountEntity {
  String id;
  DateTime? createdAt;
  DateTime? updatedAt;
  double? boughtAmount;
  String? shoppingListItemTo;
  String? createdBy;

  BoughtAmountEntity({
    required this.id,
    this.createdAt,
    this.boughtAmount,
    this.shoppingListItemTo,
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
      shoppingListItemTo:
          newEntity.shoppingListItemTo ?? oldEntity.shoppingListItemTo,
      createdBy: newEntity.createdBy ?? oldEntity.createdBy,
      createdAt: newEntity.createdAt ?? oldEntity.createdAt,
      updatedAt: newEntity.updatedAt ?? oldEntity.updatedAt,
    );
  }
}
