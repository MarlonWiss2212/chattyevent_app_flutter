class FindBoughtAmountsFilter {
  final String shoppingListItemTo;

  FindBoughtAmountsFilter({required this.shoppingListItemTo});

  Map<dynamic, dynamic> toMap() {
    return {
      "shoppingListItemTo": shoppingListItemTo,
    };
  }
}
