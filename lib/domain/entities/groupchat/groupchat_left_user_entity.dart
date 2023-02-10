class GroupchatLeftUserEntity {
  final String userId;
  final DateTime? leftAt;

  GroupchatLeftUserEntity({
    required this.userId,
    this.leftAt,
  });

  factory GroupchatLeftUserEntity.merge({
    required GroupchatLeftUserEntity newEntity,
    required GroupchatLeftUserEntity oldEntity,
  }) {
    return GroupchatLeftUserEntity(
      userId: newEntity.userId,
      leftAt: newEntity.leftAt ?? oldEntity.leftAt,
    );
  }
}
