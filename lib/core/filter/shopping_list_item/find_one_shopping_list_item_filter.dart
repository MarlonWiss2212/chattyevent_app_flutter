class FindOneShoppingListItemFilter {
  final String shoppingListItemId;

  FindOneShoppingListItemFilter({required this.shoppingListItemId});

  Map<dynamic, dynamic> toMap() {
    return {"shoppingListItemId": shoppingListItemId};
  }
}
