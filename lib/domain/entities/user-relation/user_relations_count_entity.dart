class UserRelationsCountEntity {
  final int? followerCount;
  final int? followedCount;
  final int? followRequestCount;

  UserRelationsCountEntity({
    this.followedCount,
    this.followerCount,
    this.followRequestCount,
  });

  factory UserRelationsCountEntity.merge({
    required UserRelationsCountEntity newEntity,
    required UserRelationsCountEntity oldEntity,
  }) {
    return UserRelationsCountEntity(
      followerCount: newEntity.followerCount ?? oldEntity.followerCount,
      followedCount: newEntity.followedCount ?? oldEntity.followedCount,
      followRequestCount:
          newEntity.followRequestCount ?? oldEntity.followRequestCount,
    );
  }
}
