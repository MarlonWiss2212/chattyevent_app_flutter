class FindFollowersFilter {
  final String targetUserId;
  final String? followedToPrivateEventPermission;
  final String? followedToGroupchatPermission;

  FindFollowersFilter({
    required this.targetUserId,
    this.followedToGroupchatPermission,
    this.followedToPrivateEventPermission,
  });

  Map<dynamic, dynamic> toMap() {
    Map<dynamic, dynamic> map = {"targetUserId": targetUserId};

    if (followedToPrivateEventPermission != null) {
      map.addAll({
        "followedToPrivateEventPermission": followedToPrivateEventPermission,
      });
    }

    if (followedToGroupchatPermission != null) {
      map.addAll({
        "followedToGroupchatPermission": followedToGroupchatPermission,
      });
    }

    return map;
  }
}
