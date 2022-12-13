class GroupchatUserEntity {
  final String userId;
  final bool? admin;
  final DateTime? joinedAt;

  GroupchatUserEntity({
    required this.userId,
    this.admin,
    this.joinedAt,
  });
}
