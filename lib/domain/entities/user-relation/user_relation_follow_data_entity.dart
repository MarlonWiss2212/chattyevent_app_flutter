class UserRelationFollowDataEntity {
  final DateTime? followedUserAt;
  final DateTime? updatedAt;

  UserRelationFollowDataEntity({
    this.followedUserAt,
    this.updatedAt,
  });

  factory UserRelationFollowDataEntity.merge({
    required UserRelationFollowDataEntity newEntity,
    required UserRelationFollowDataEntity oldEntity,
  }) {
    return UserRelationFollowDataEntity(
      followedUserAt: newEntity.followedUserAt ?? oldEntity.followedUserAt,
      updatedAt: newEntity.updatedAt ?? oldEntity.updatedAt,
    );
  }
}
