class CreateShoppingListItemDto {
  String itemName;
  String? unit;
  double amount;
  String userToBuyItem;
  String privateEvent;

  CreateShoppingListItemDto({
    required this.itemName,
    this.unit,
    required this.amount,
    required this.userToBuyItem,
    required this.privateEvent,
  });

  Map<dynamic, dynamic> toMap() {
    return {
      'itemName': itemName,
      'unit': unit,
      'amount': amount,
      'userToBuyItem': userToBuyItem,
      'privateEvent': privateEvent,
    };
  }
}
