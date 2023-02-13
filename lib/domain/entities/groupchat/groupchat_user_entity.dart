class GroupchatUserEntity {
  final String id;
  final String? userId;
  final String? usernameForChat;
  final bool? admin;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  GroupchatUserEntity({
    required this.id,
    this.admin,
    this.userId,
    this.usernameForChat,
    this.createdAt,
    this.updatedAt,
  });

  factory GroupchatUserEntity.merge({
    required GroupchatUserEntity newEntity,
    required GroupchatUserEntity oldEntity,
  }) {
    return GroupchatUserEntity(
      id: newEntity.id,
      admin: newEntity.admin ?? oldEntity.admin,
      createdAt: newEntity.createdAt ?? oldEntity.createdAt,
      usernameForChat: newEntity.usernameForChat ?? oldEntity.usernameForChat,
      updatedAt: newEntity.updatedAt ?? oldEntity.updatedAt,
      userId: newEntity.userId ?? oldEntity.userId,
    );
  }
}
