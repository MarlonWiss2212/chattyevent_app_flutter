class PrivateEventEntity {
  final String id;
  final String? title;
  final String? coverImageLink;
  final dynamic usersThatWillBeThere;
  final dynamic usersThatWillNotBeThere;
  final String? eventDate;
  final String? connectedGroupchat;
  final String? createdBy;
  final String? createdAt;

  PrivateEventEntity({
    required this.id,
    this.title,
    this.coverImageLink,
    this.usersThatWillBeThere,
    this.usersThatWillNotBeThere,
    this.eventDate,
    this.connectedGroupchat,
    this.createdBy,
    this.createdAt,
  });
}
