class UserRelationFollowDataEntity {
  final bool? canInviteFollowedToPrivateEvent;
  final bool? canInviteFollowedToGroupchat;
  final DateTime? followedUserAt;

  UserRelationFollowDataEntity({
    this.canInviteFollowedToPrivateEvent,
    this.canInviteFollowedToGroupchat,
    this.followedUserAt,
  });

  factory UserRelationFollowDataEntity.merge({
    required UserRelationFollowDataEntity newEntity,
    required UserRelationFollowDataEntity oldEntity,
  }) {
    return UserRelationFollowDataEntity(
      canInviteFollowedToPrivateEvent:
          newEntity.canInviteFollowedToPrivateEvent ??
              oldEntity.canInviteFollowedToPrivateEvent,
      canInviteFollowedToGroupchat: newEntity.canInviteFollowedToGroupchat ??
          oldEntity.canInviteFollowedToGroupchat,
      followedUserAt: newEntity.followedUserAt ?? oldEntity.followedUserAt,
    );
  }
}
