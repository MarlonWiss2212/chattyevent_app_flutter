class CreateBoughtAmountDto {
  final double boughtAmount;
  final String shoppingListItemTo;

  CreateBoughtAmountDto({
    required this.shoppingListItemTo,
    required this.boughtAmount,
  });

  Map<dynamic, dynamic> toMap() {
    Map<dynamic, dynamic> map = {
      "boughtAmount": boughtAmount,
      "shoppingListItemTo": shoppingListItemTo,
    };
    return map;
  }
}
