class FindShoppingListItemsFilter {
  final String? privateEventTo;

  FindShoppingListItemsFilter({
    this.privateEventTo,
  });

  Map<dynamic, dynamic> toMap() {
    Map<dynamic, dynamic> map = {};
    if (privateEventTo != null) {
      map.addAll({
        "privateEventTo": privateEventTo,
      });
    }
    return map;
  }
}
