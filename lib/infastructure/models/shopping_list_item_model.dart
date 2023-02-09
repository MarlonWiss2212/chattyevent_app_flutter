import 'package:social_media_app_flutter/domain/entities/shopping_list_item_entity.dart';

class ShoppingListItemModel extends ShoppingListItemEntity {
  ShoppingListItemModel({
    required String id,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? itemName,
    String? unit,
    double? amount,
    double? boughtAmount,
    String? userToBuyItem,
    String? createdBy,
    String? privateEvent,
  }) : super(
          id: id,
          createdAt: createdAt,
          updatedAt: updatedAt,
          itemName: itemName,
          createdBy: createdBy,
          unit: unit,
          amount: amount,
          boughtAmount: boughtAmount,
          userToBuyItem: userToBuyItem,
          privateEvent: privateEvent,
        );

  factory ShoppingListItemModel.fromJson(Map<String, dynamic> json) {
    final createdAt = json["createdAt"] != null
        ? DateTime.parse(json["createdAt"]).toLocal()
        : null;
    final updatedAt = json["updatedAt"] != null
        ? DateTime.parse(json["updatedAt"]).toLocal()
        : null;

    return ShoppingListItemModel(
      id: json["_id"],
      createdAt: createdAt,
      updatedAt: updatedAt,
      itemName: json["itemName"],
      unit: json["unit"],
      amount: json["amount"],
      createdBy: json["createdBy"],
      boughtAmount: json['boughtAmount'],
      userToBuyItem: json["userToBuyItem"],
      privateEvent: json["privateEvent"],
    );
  }
}
