class CreatePrivateEventDto {
  String title;
  String? coverImageLink;
  String connectedGroupchat;
  DateTime eventDate;

  CreatePrivateEventDto({
    required this.title,
    this.coverImageLink,
    required this.connectedGroupchat,
    required this.eventDate,
  });

  Map<dynamic, dynamic> toMap() {
    return {
      'title': title,
      'coverImageLink': coverImageLink,
      'connectedGroupchat': connectedGroupchat,
      'eventDate': eventDate.toIso8601String(),
    };
  }
}
