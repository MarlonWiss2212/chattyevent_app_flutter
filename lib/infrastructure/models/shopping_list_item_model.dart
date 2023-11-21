import 'package:chattyevent_app_flutter/domain/entities/bought_amount_entity.dart';
import 'package:chattyevent_app_flutter/domain/entities/shopping_list_item/shopping_list_item_entity.dart';
import 'package:chattyevent_app_flutter/infrastructure/models/bought_amount_model.dart';

class ShoppingListItemModel extends ShoppingListItemEntity {
  ShoppingListItemModel({
    required String id,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? itemName,
    String? unit,
    double? amount,
    List<BoughtAmountEntity>? boughtAmounts,
    String? userToBuyItem,
    String? createdBy,
    String? eventTo,
  }) : super(
          id: id,
          createdAt: createdAt,
          updatedAt: updatedAt,
          itemName: itemName,
          createdBy: createdBy,
          unit: unit,
          amount: amount,
          boughtAmounts: boughtAmounts,
          userToBuyItem: userToBuyItem,
          eventTo: eventTo,
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

    List<BoughtAmountEntity>? boughtAmounts;
    if (json['boughtAmounts'] != null) {
      boughtAmounts ??= [];
      for (final boughtAmount in json['boughtAmounts']) {
        boughtAmounts.add(BoughtAmountModel.fromJson(boughtAmount));
      }
    }

    return ShoppingListItemModel(
      id: json["_id"],
      createdAt: createdAt,
      updatedAt: updatedAt,
      itemName: json["itemName"],
      unit: json["unit"],
      amount: amount,
      createdBy: json["createdBy"],
      boughtAmounts: boughtAmounts,
      userToBuyItem: json["userToBuyItem"],
      eventTo: json["eventTo"],
    );
  }
}
