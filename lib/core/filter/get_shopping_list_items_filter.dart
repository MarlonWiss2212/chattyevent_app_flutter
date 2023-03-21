class GetShoppingListItemsFilter {
  String? privateEventId;

  GetShoppingListItemsFilter({this.privateEventId});

  Map<dynamic, dynamic> toMap() {
    Map<dynamic, dynamic> map = {};
    if (privateEventId != null) {
      map.addAll({"privateEventId": privateEventId});
    }
    return map;
  }
}
