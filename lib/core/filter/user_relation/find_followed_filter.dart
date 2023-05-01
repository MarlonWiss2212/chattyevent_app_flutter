class FindFollowedFilter {
  final String requesterUserId;
  final String? followedToPrivateEventPermission;
  final String? followedToGroupchatPermission;

  FindFollowedFilter({
    required this.requesterUserId,
    this.followedToGroupchatPermission,
    this.followedToPrivateEventPermission,
  });

  Map<dynamic, dynamic> toMap() {
    Map<dynamic, dynamic> map = {"requesterUserId": requesterUserId};

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
