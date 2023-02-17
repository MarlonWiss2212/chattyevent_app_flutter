class GetUsersFilter {
  String? search;

  GetUsersFilter({this.search});

  Map<dynamic, dynamic> toMap() {
    Map<dynamic, dynamic> map = {};
    if (search != null) {
      map.addAll({"search": search});
    }
    return map;
  }
}
