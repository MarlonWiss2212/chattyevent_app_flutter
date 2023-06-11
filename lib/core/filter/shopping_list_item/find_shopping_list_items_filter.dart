class FindShoppingListItemsFilter {
  final String? privateEventId;
  //final String? privateEventTo;

  FindShoppingListItemsFilter({
    this.privateEventId,
    //this.privateEventTo,
  });

  Map<dynamic, dynamic> toMap() {
    Map<dynamic, dynamic> map = {};
    if (privateEventId != null) {
      map.addAll({
        "privateEventId": privateEventId,
        // "privateEventTo": privateEventTo,
      });
    }
    return map;
  }
}
