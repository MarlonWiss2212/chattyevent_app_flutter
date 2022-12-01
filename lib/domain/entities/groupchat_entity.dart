class GroupchatEntity {
  final String id;
  final String? title;
  final String? profileImageLink;
  final dynamic users;
  final dynamic leftUsers;
  final String? description;
  final String? chatColorCode;
  final String? createdBy;
  final String? createdAt;

  GroupchatEntity({
    required this.id,
    this.title,
    this.description,
    this.profileImageLink,
    this.users,
    this.leftUsers,
    this.chatColorCode,
    this.createdBy,
    this.createdAt,
  });
}
