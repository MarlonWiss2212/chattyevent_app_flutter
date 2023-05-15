class UserRelationFollowDataEntity {
  final String? requesterPrivateEventAddPermission;
  final String? requesterGroupchatAddPermission;
  final DateTime? followedUserAt;

  UserRelationFollowDataEntity({
    this.requesterPrivateEventAddPermission,
    this.requesterGroupchatAddPermission,
    this.followedUserAt,
  });

  factory UserRelationFollowDataEntity.merge({
    required UserRelationFollowDataEntity newEntity,
    required UserRelationFollowDataEntity oldEntity,
  }) {
    return UserRelationFollowDataEntity(
      requesterPrivateEventAddPermission:
          newEntity.requesterPrivateEventAddPermission ??
              oldEntity.requesterPrivateEventAddPermission,
      requesterGroupchatAddPermission:
          newEntity.requesterGroupchatAddPermission ??
              oldEntity.requesterGroupchatAddPermission,
      followedUserAt: newEntity.followedUserAt ?? oldEntity.followedUserAt,
    );
  }
}
