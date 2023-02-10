class GroupchatUserEntity {
  final String userId;
  final bool? admin;
  final DateTime? joinedAt;

  GroupchatUserEntity({
    required this.userId,
    this.admin,
    this.joinedAt,
  });

  factory GroupchatUserEntity.merge({
    required GroupchatUserEntity newEntity,
    required GroupchatUserEntity oldEntity,
  }) {
    return GroupchatUserEntity(
      userId: newEntity.userId,
      admin: newEntity.admin ?? oldEntity.admin,
      joinedAt: newEntity.joinedAt ?? oldEntity.joinedAt,
    );
  }
}
