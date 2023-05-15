class FindFollowedFilter {
  final String requesterUserId;
  final String? requesterPrivateEventAddPermission;
  final String? requesterGroupchatAddPermission;

  FindFollowedFilter({
    required this.requesterUserId,
    this.requesterGroupchatAddPermission,
    this.requesterPrivateEventAddPermission,
  });

  Map<dynamic, dynamic> toMap() {
    Map<dynamic, dynamic> map = {"requesterUserId": requesterUserId};

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
