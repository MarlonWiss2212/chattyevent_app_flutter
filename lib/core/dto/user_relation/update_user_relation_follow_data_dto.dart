class UpdateUserRelationFollowDataDto {
  final String? requesterPrivateEventAddPermission;
  final String? requesterGroupchatAddPermission;

  UpdateUserRelationFollowDataDto({
    this.requesterPrivateEventAddPermission,
    this.requesterGroupchatAddPermission,
  });

  Map<dynamic, dynamic> toMap() {
    Map<dynamic, dynamic> map = {};

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
