class CreateShoppingListItemDto {
  final String itemName;
  final String? unit;
  final double amount;
  final String userToBuyItem;
  final String privateEventTo;

  CreateShoppingListItemDto({
    required this.itemName,
    this.unit,
    required this.amount,
    required this.userToBuyItem,
    required this.privateEventTo,
  });

  Map<dynamic, dynamic> toMap() {
    Map<dynamic, dynamic> map = {
      'itemName': itemName,
      'amount': amount,
      'userToBuyItem': userToBuyItem,
      'privateEventTo': privateEventTo,
    };

    if (unit != null) {
      map.addAll({'unit': unit});
    }

    return map;
  }
}
