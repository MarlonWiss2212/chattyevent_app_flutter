import 'package:social_media_app_flutter/domain/entities/bought_amount_entity.dart';

class ShoppingListItemEntity {
  String id;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? itemName;
  String? unit;
  double? amount;
  List<BoughtAmountEntity>? boughtAmount;
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
    bool setBoughtAmountFromOldEntity = false,
  }) {
    List<BoughtAmountEntity>? boughtAmount =
        setBoughtAmountFromOldEntity ? oldEntity.boughtAmount : [];
    if (newEntity.boughtAmount != null) {
      for (final newBoughtAmount in newEntity.boughtAmount!) {
        if (boughtAmount == null) {
          boughtAmount ??= [];
          boughtAmount.add(newBoughtAmount);
          continue;
        }
        final userIndex = boughtAmount.indexWhere(
          (element) => element.id == newBoughtAmount.id,
        );
        if (userIndex == -1) {
          boughtAmount.add(newBoughtAmount);
        } else {
          boughtAmount[userIndex] = BoughtAmountEntity.merge(
            newEntity: newBoughtAmount,
            oldEntity: boughtAmount[userIndex],
          );
        }
      }
    }

    return ShoppingListItemEntity(
      id: newEntity.id,
      itemName: newEntity.itemName ?? oldEntity.itemName,
      unit: newEntity.unit ?? oldEntity.unit,
      amount: newEntity.amount ?? oldEntity.amount,
      boughtAmount: boughtAmount,
      userToBuyItem: newEntity.userToBuyItem ?? oldEntity.userToBuyItem,
      privateEventId: newEntity.privateEventId ?? oldEntity.privateEventId,
      createdBy: newEntity.createdBy ?? oldEntity.createdBy,
      createdAt: newEntity.createdAt ?? oldEntity.createdAt,
      updatedAt: newEntity.updatedAt ?? oldEntity.updatedAt,
    );
  }
}
