class FindFollowersFilter {
  final String targetUserId;
  final String? requesterPrivateEventAddPermission;
  final String? requesterGroupchatAddPermission;

  FindFollowersFilter({
    required this.targetUserId,
    this.requesterGroupchatAddPermission,
    this.requesterPrivateEventAddPermission,
  });

  Map<dynamic, dynamic> toMap() {
    Map<dynamic, dynamic> map = {"targetUserId": targetUserId};

    if (requesterPrivateEventAddPermission != null) {
      map.addAll({
        "requesterPrivateEventAddPermission":
            requesterPrivateEventAddPermission,
      });
    }

    if (requesterGroupchatAddPermission != null) {
      map.addAll({
        "requesterGroupchatAddPermission": requesterGroupchatAddPermission,
      });
    }

    return map;
  }
}
