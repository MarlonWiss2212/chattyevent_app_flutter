class FindAllFollowerUserRelationFilter {
  final bool? getFollowers;
  final bool? getFollowed;
  final bool? getFollowerRequests;
  final String userId;

  FindAllFollowerUserRelationFilter({
    this.getFollowers = true,
    this.getFollowed = true,
    this.getFollowerRequests = true,
    required this.userId,
  });

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {};
    if (getFollowers != null) map["getFollowers"] = getFollowers;
    if (getFollowed != null) map["getFollowed"] = getFollowed;
    if (getFollowerRequests != null) {
      map["getFollowerRequests"] = getFollowerRequests;
    }
    map["userId"] = userId;
    return map;
  }
}
