import 'package:chattyevent_app_flutter/domain/entities/bought_amount_entity.dart';

class BoughtAmountModel extends BoughtAmountEntity {
  BoughtAmountModel({
    required String id,
    DateTime? createdAt,
    DateTime? updatedAt,
    double? boughtAmount,
    String? shoppingListItemId,
    String? createdBy,
  }) : super(
          id: id,
          createdAt: createdAt,
          updatedAt: updatedAt,
          boughtAmount: boughtAmount,
          shoppingListItemId: shoppingListItemId,
          createdBy: createdBy,
        );

  factory BoughtAmountModel.fromJson(Map<String, dynamic> json) {
    final createdAt = json["createdAt"] != null
        ? DateTime.parse(json["createdAt"]).toLocal()
        : null;
    final updatedAt = json["updatedAt"] != null
        ? DateTime.parse(json["updatedAt"]).toLocal()
        : null;

    final boughtAmount = json["boughtAmount"] == null
        ? null
        : json["boughtAmount"] is double
            ? json["boughtAmount"]
            : double.tryParse(json["boughtAmount"].toString());

    return BoughtAmountModel(
      id: json['_id'],
      createdAt: createdAt,
      updatedAt: updatedAt,
      boughtAmount: boughtAmount,
      shoppingListItemId: json['shoppingListItemId'],
      createdBy: json["createdBy"],
    );
  }
}
