class FindUsersFilter {
  final String? search;
  final List<String>? userIds;

  FindUsersFilter({
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
