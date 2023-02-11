class GetShoppingListItemsFilter {
  String privateEventId;

  GetShoppingListItemsFilter({required this.privateEventId});

  Map<dynamic, dynamic> toMap() {
    return {"privateEventId": privateEventId};
  }
}
