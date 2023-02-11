class CreateShoppingListItemDto {
  String itemName;
  String? unit;
  double amount;
  String userToBuyItem;
  String privateEventId;

  CreateShoppingListItemDto({
    required this.itemName,
    this.unit,
    required this.amount,
    required this.userToBuyItem,
    required this.privateEventId,
  });

  Map<dynamic, dynamic> toMap() {
    return {
      'itemName': itemName,
      'unit': unit,
      'amount': amount,
      'userToBuyItem': userToBuyItem,
      'privateEventId': privateEventId,
    };
  }
}
