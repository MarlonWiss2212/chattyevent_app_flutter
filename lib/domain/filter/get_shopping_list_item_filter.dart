class GetShoppingListItemsFilter {
  String privateEvent;

  GetShoppingListItemsFilter({required this.privateEvent});

  Map<dynamic, dynamic> toMap() {
    return {"privateEvent": privateEvent};
  }
}
