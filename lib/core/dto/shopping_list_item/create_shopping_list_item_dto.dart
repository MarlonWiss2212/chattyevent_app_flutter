class CreateShoppingListItemDto {
  final String itemName;
  final String? unit;
  final double amount;
  final String userToBuyItem;
  final String privateEventId;

  CreateShoppingListItemDto({
    required this.itemName,
    this.unit,
    required this.amount,
    required this.userToBuyItem,
    required this.privateEventId,
  });

  Map<dynamic, dynamic> toMap() {
    Map<dynamic, dynamic> map = {
      'itemName': itemName,
      'amount': amount,
      'userToBuyItem': userToBuyItem,
      'privateEventId': privateEventId,
    };

    if (unit != null) {
      map.addAll({'unit': unit});
    }

    return map;
  }
}
