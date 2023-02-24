class GetBoughtAmountFilter {
  String? shoppingListItemId;

  GetBoughtAmountFilter({
    this.shoppingListItemId,
  });

  Map<dynamic, dynamic> toMap() {
    Map<dynamic, dynamic> map = {};
    if (shoppingListItemId != null) {
      map.addAll({"shoppingListItemId": shoppingListItemId});
    }
    return map;
  }
}
