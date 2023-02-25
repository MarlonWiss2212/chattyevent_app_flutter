class GetOneShoppingListItemsFilter {
  String id;

  GetOneShoppingListItemsFilter({required this.id});

  Map<dynamic, dynamic> toMap() {
    return {"_id": id};
  }
}
