class FindUsersFilter {
  final String? search;

  FindUsersFilter({this.search});

  Map<dynamic, dynamic> toMap() {
    Map<dynamic, dynamic> map = {};
    if (search != null) {
      map.addAll({"search": search});
    }
    return map;
  }
}
