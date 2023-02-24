class UpdateShoppingListItemDto {
  String? itemName;
  String? unit;
  double? amount;
  String? userToBuyItem;

  UpdateShoppingListItemDto({
    this.itemName,
    this.unit,
    this.amount,
    this.userToBuyItem,
  });

  Map<dynamic, dynamic> toMap() {
    Map<dynamic, dynamic> map = {};

    if (itemName != null) {
      map.addAll({"itemName": itemName});
    }
    if (unit != null) {
      map.addAll({"unit": unit});
    }
    if (amount != null) {
      map.addAll({"amount": amount});
    }
    if (userToBuyItem != null) {
      map.addAll({"userToBuyItem": userToBuyItem});
    }
    return map;
  }
}
