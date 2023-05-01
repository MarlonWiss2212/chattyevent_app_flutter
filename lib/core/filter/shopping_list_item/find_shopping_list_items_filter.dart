class FindShoppingListItemsFilter {
  final String? privateEventId;

  FindShoppingListItemsFilter({this.privateEventId});

  Map<dynamic, dynamic> toMap() {
    Map<dynamic, dynamic> map = {};
    if (privateEventId != null) {
      map.addAll({"privateEventId": privateEventId});
    }
    return map;
  }
}
