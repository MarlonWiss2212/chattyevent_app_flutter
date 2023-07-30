class FindShoppingListItemsFilter {
  final String? eventTo;

  FindShoppingListItemsFilter({
    this.eventTo,
  });

  Map<dynamic, dynamic> toMap() {
    Map<dynamic, dynamic> map = {};
    if (eventTo != null) {
      map.addAll({
        "eventTo": eventTo,
      });
    }
    return map;
  }
}
