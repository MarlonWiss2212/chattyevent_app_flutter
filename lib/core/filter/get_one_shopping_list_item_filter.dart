class GetOneShoppingListItemFilter {
  String id;

  GetOneShoppingListItemFilter({required this.id});

  Map<dynamic, dynamic> toMap() {
    return {"_id": id};
  }
}
