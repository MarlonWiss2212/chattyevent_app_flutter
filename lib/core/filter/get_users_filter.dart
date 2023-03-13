class GetUsersFilter {
  String? search;
  List<String>? userIds;

  GetUsersFilter({
    this.search,
    this.userIds,
  });

  Map<dynamic, dynamic> toMap() {
    Map<dynamic, dynamic> map = {};
    if (search != null) {
      map.addAll({"search": search});
    }
    if (userIds != null) {
      map.addAll({"userIds": userIds});
    }
    return map;
  }
}
