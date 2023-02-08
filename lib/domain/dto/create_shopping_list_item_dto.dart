class CreateShoppingListItemDto {
  String itemName;
  String? unit;
  double amount;
  double? boughtAmount;
  String userToBuyItem;
  String privateEvent;

  CreateShoppingListItemDto({
    required this.itemName,
    this.unit,
    required this.amount,
    this.boughtAmount,
    required this.userToBuyItem,
    required this.privateEvent,
  });

  Map<dynamic, dynamic> toMap() {
    return {
      'itemName': itemName,
      'unit': unit,
      'amount': amount,
      'boughtAmount': boughtAmount,
      'userToBuyItem': userToBuyItem,
      'privateEvent': privateEvent,
    };
  }
}
