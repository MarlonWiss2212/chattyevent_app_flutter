import 'package:chattyevent_app_flutter/domain/entities/bought_amount_entity.dart';

class ShoppingListItemEntity {
  final String id;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? itemName;
  final String? unit;
  final double? amount;
  final List<BoughtAmountEntity>? boughtAmounts;
  final String? userToBuyItem;
  final String? eventTo;
  final String? createdBy;

  ShoppingListItemEntity({
    required this.id,
    this.createdAt,
    this.amount,
    this.itemName,
    this.eventTo,
    this.boughtAmounts,
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
      boughtAmounts: newEntity.boughtAmounts ?? oldEntity.boughtAmounts,
      userToBuyItem: newEntity.userToBuyItem ?? oldEntity.userToBuyItem,
      eventTo: newEntity.eventTo ?? oldEntity.eventTo,
      createdBy: newEntity.createdBy ?? oldEntity.createdBy,
      createdAt: newEntity.createdAt ?? oldEntity.createdAt,
      updatedAt: newEntity.updatedAt ?? oldEntity.updatedAt,
    );
  }
}
