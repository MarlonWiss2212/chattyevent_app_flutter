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
    String? privateEventId,
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
          privateEventId: privateEventId,
        );

  factory ShoppingListItemModel.fromJson(Map<String, dynamic> json) {
    final createdAt = json["createdAt"] != null
        ? DateTime.parse(json["createdAt"]).toLocal()
        : null;
    final updatedAt = json["updatedAt"] != null
        ? DateTime.parse(json["updatedAt"]).toLocal()
        : null;

    final amount = json["amount"] == null
        ? null
        : json["amount"] is double
            ? json["amount"]
            : double.tryParse(json["amount"].toString());

    final boughtAmount = json["boughtAmount"] == null
        ? null
        : json["boughtAmount"] is double
            ? json["boughtAmount"]
            : double.tryParse(json["boughtAmount"].toString());

    return ShoppingListItemModel(
      id: json["_id"],
      createdAt: createdAt,
      updatedAt: updatedAt,
      itemName: json["itemName"],
      unit: json["unit"],
      amount: amount,
      createdBy: json["createdBy"],
      boughtAmount: boughtAmount,
      userToBuyItem: json["userToBuyItem"],
      privateEventId: json["privateEventId"],
    );
  }
}
