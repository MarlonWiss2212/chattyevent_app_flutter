class FindOneShoppingListItemFilter {
  final String shoppingListItemTo;

  FindOneShoppingListItemFilter({
    required this.shoppingListItemTo,
  });

  Map<dynamic, dynamic> toMap() {
    return {
      "shoppingListItemTo": shoppingListItemTo,
    };
  }
}
