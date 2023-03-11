class UpdateUserRelationFollowDataDto {
  final String? canInviteFollowedToPrivateEvent;
  final String? canInviteFollowedToGroupchat;

  UpdateUserRelationFollowDataDto({
    this.canInviteFollowedToPrivateEvent,
    this.canInviteFollowedToGroupchat,
  });

  Map<dynamic, dynamic> toMap() {
    Map<dynamic, dynamic> map = {};

    if (canInviteFollowedToPrivateEvent != null) {
      map.addAll({
        "canInviteFollowedToPrivateEvent": canInviteFollowedToPrivateEvent,
      });
    }

    if (canInviteFollowedToPrivateEvent != null) {
      map.addAll({
        "canInviteFollowedToGroupchat": canInviteFollowedToGroupchat,
      });
    }

    return map;
  }
}
