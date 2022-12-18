class PrivateEventEntity {
  final String id;
  final String? title;
  final String? coverImageLink;
  final List<String>? usersThatWillBeThere;
  final List<String>? usersThatWillNotBeThere;
  final DateTime eventDate;
  final String? connectedGroupchat;
  final String? createdBy;
  final DateTime? createdAt;

  PrivateEventEntity({
    required this.id,
    this.title,
    this.coverImageLink,
    this.usersThatWillBeThere,
    this.usersThatWillNotBeThere,
    required this.eventDate,
    this.connectedGroupchat,
    this.createdBy,
    this.createdAt,
  });
}
