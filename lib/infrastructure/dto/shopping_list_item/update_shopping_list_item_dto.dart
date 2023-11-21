class UpdateShoppingListItemDto {
  final String? itemName;
  final String? unit;
  final double? amount;
  final String? userToBuyItem;

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
