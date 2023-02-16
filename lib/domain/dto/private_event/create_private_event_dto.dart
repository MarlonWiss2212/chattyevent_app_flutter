import 'dart:io';

import 'package:social_media_app_flutter/domain/dto/private_event/create_location_private_event_dto.dart';

class CreatePrivateEventDto {
  String title;
  String? description;
  File coverImage;
  String connectedGroupchat;
  DateTime eventDate;
  CreatePrivateEventLocationDto? eventLocation;

  CreatePrivateEventDto({
    required this.title,
    required this.coverImage,
    required this.connectedGroupchat,
    required this.eventDate,
    this.eventLocation,
  });

  Map<dynamic, dynamic> toMap() {
    Map<dynamic, dynamic> map = {
      "title": title,
      "connectedGroupchat": connectedGroupchat,
      "eventDate": eventDate.toIso8601String(),
    };
    if (eventLocation != null) {
      map.addAll({"eventLocation": eventLocation!.toMap()});
    }
    if (description != null) {
      map.addAll({'description': description});
    }

    return map;
  }
}
