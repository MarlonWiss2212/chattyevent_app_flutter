class CreateBoughtAmountDto {
  double boughtAmount;
  String shoppingListItemId;

  CreateBoughtAmountDto({
    required this.shoppingListItemId,
    required this.boughtAmount,
  });

  Map<dynamic, dynamic> toMap() {
    Map<dynamic, dynamic> map = {
      "boughtAmount": boughtAmount,
      "shoppingListItemId": shoppingListItemId,
    };
    return map;
  }
}
