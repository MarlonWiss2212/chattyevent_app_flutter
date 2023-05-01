class UserRelationFollowDataEntity {
  final String? followedToPrivateEventPermission;
  final String? followedToGroupchatPermission;
  final DateTime? followedUserAt;

  UserRelationFollowDataEntity({
    this.followedToPrivateEventPermission,
    this.followedToGroupchatPermission,
    this.followedUserAt,
  });

  factory UserRelationFollowDataEntity.merge({
    required UserRelationFollowDataEntity newEntity,
    required UserRelationFollowDataEntity oldEntity,
  }) {
    return UserRelationFollowDataEntity(
      followedToPrivateEventPermission:
          newEntity.followedToPrivateEventPermission ??
              oldEntity.followedToPrivateEventPermission,
      followedToGroupchatPermission: newEntity.followedToGroupchatPermission ??
          oldEntity.followedToGroupchatPermission,
      followedUserAt: newEntity.followedUserAt ?? oldEntity.followedUserAt,
    );
  }
}
