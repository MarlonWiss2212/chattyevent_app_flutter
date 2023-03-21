import 'dart:io';

import 'package:social_media_app_flutter/core/dto/private_event/create_location_private_event_dto.dart';

class CreatePrivateEventDto {
  String title;
  String? description;
  File coverImage;
  String? groupchatTo;
  DateTime eventDate;
  DateTime? eventEndDate;
  CreatePrivateEventLocationDto? eventLocation;

  CreatePrivateEventDto({
    required this.title,
    required this.coverImage,
    required this.groupchatTo,
    required this.eventDate,
    this.eventEndDate,
    this.description,
    this.eventLocation,
  });

  Map<dynamic, dynamic> toMap() {
    Map<dynamic, dynamic> map = {
      "title": title,
      "eventDate": eventDate.toIso8601String(),
    };
    if (groupchatTo != null) {
      map.addAll({"groupchatTo": groupchatTo});
    }
    if (eventLocation != null) {
      map.addAll({"eventLocation": eventLocation!.toMap()});
    }
    if (description != null) {
      map.addAll({'description': description});
    }
    if (eventEndDate != null) {
      map.addAll({'eventEndDate': eventEndDate});
    }

    return map;
  }
}
