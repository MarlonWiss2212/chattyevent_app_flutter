class FindBoughtAmountsFilter {
  final String shoppingListItemId;
// final String shoppingListItemTo;

  FindBoughtAmountsFilter({required this.shoppingListItemId});

  Map<dynamic, dynamic> toMap() {
    return {
      "shoppingListItemId": shoppingListItemId,
      // "shoppingListItemTo": shoppingListItemTo,
    };
  }
}
