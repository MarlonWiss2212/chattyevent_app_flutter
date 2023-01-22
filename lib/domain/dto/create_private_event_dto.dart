import 'dart:io';

class CreatePrivateEventDto {
  String title;
  File coverImage;
  String connectedGroupchat;
  DateTime eventDate;

  CreatePrivateEventDto({
    required this.title,
    required this.coverImage,
    required this.connectedGroupchat,
    required this.eventDate,
  });

  Map<dynamic, dynamic> toMap() {
    return {
      "title": title,
      "connectedGroupchat": connectedGroupchat,
      "eventDate": eventDate.toIso8601String(),
    };
  }
}
