class GroupchatUserEntity {
  final String id;
  final String? authId;
  final String? usernameForChat;
  final bool? admin;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  GroupchatUserEntity({
    required this.id,
    this.admin,
    this.authId,
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
      authId: newEntity.authId ?? oldEntity.authId,
    );
  }
}
