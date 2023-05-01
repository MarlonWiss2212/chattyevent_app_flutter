class UpdateUserRelationFollowDataDto {
  final String? followedToPrivateEventPermission;
  final String? followedToGroupchatPermission;

  UpdateUserRelationFollowDataDto({
    this.followedToPrivateEventPermission,
    this.followedToGroupchatPermission,
  });

  Map<dynamic, dynamic> toMap() {
    Map<dynamic, dynamic> map = {};

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
