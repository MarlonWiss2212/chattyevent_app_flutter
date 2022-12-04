class GroupchatUserEntity {
  final String userId;
  final bool? admin;
  final String? joinedAt;

  GroupchatUserEntity({
    required this.userId,
    this.admin,
    this.joinedAt,
  });
}
