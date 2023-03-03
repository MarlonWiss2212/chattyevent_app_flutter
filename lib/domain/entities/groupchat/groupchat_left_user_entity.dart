class GroupchatLeftUserEntity {
  final String id;
  final String? authId;
  final String? leftGroupchatTo;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  GroupchatLeftUserEntity({
    required this.id,
    this.createdAt,
    this.leftGroupchatTo,
    this.updatedAt,
    this.authId,
  });

  factory GroupchatLeftUserEntity.merge({
    required GroupchatLeftUserEntity newEntity,
    required GroupchatLeftUserEntity oldEntity,
  }) {
    return GroupchatLeftUserEntity(
      authId: newEntity.authId,
      id: newEntity.id,
      leftGroupchatTo: newEntity.leftGroupchatTo ?? oldEntity.leftGroupchatTo,
      updatedAt: newEntity.updatedAt ?? oldEntity.updatedAt,
      createdAt: newEntity.createdAt ?? oldEntity.createdAt,
    );
  }
}
