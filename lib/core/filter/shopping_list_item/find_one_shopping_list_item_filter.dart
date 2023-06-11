class FindOneShoppingListItemFilter {
  final String shoppingListItemId;
  // final String shoppingListItemTo;

  FindOneShoppingListItemFilter({
    required this.shoppingListItemId,
    // required this.shoppingListItemTo,
  });

  Map<dynamic, dynamic> toMap() {
    return {
      "shoppingListItemId": shoppingListItemId,
      //"shoppingListItemTo": shoppingListItemTo,
    };
  }
}
