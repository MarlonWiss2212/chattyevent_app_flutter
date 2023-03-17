class GroupchatLeftUserEntity {
  final String id;
  final String? userId;
  final String? groupchatTo;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  GroupchatLeftUserEntity({
    required this.id,
    this.createdAt,
    this.groupchatTo,
    this.updatedAt,
    this.userId,
  });

  factory GroupchatLeftUserEntity.merge({
    required GroupchatLeftUserEntity newEntity,
    required GroupchatLeftUserEntity oldEntity,
  }) {
    return GroupchatLeftUserEntity(
      userId: newEntity.userId,
      id: newEntity.id,
      groupchatTo: newEntity.groupchatTo ?? oldEntity.groupchatTo,
      updatedAt: newEntity.updatedAt ?? oldEntity.updatedAt,
      createdAt: newEntity.createdAt ?? oldEntity.createdAt,
    );
  }
}
