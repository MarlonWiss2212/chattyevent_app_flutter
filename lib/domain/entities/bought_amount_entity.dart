class BoughtAmountEntity {
  final String id;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final double? boughtAmount;
  final String? createdBy;

  BoughtAmountEntity({
    required this.id,
    this.createdAt,
    this.boughtAmount,
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
      createdBy: newEntity.createdBy ?? oldEntity.createdBy,
      createdAt: newEntity.createdAt ?? oldEntity.createdAt,
      updatedAt: newEntity.updatedAt ?? oldEntity.updatedAt,
    );
  }
}
