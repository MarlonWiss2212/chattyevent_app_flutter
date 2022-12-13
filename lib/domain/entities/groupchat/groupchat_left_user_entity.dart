class GroupchatLeftUserEntity {
  final String userId;
  final DateTime? leftAt;

  GroupchatLeftUserEntity({
    required this.userId,
    this.leftAt,
  });
}
