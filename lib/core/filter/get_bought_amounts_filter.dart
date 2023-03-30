class GetBoughtAmountsFilter {
  final List<String> shoppingListItemIds;

  GetBoughtAmountsFilter({
    required this.shoppingListItemIds,
  });

  Map<dynamic, dynamic> toMap() {
    Map<dynamic, dynamic> map = {"shoppingListItemIds": shoppingListItemIds};
    return map;
  }
}
