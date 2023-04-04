import 'dart:io';

import 'package:social_media_app_flutter/core/dto/private_event/create_location_private_event_dto.dart';
import 'package:social_media_app_flutter/core/dto/private_event/private_event_user/create_private_event_user_from_private_event_dto.dart';

class CreatePrivateEventDto {
  String title;
  String? description;
  File coverImage;
  String? groupchatTo;
  DateTime eventDate;
  DateTime? eventEndDate;
  CreatePrivateEventLocationDto? eventLocation;
  List<CreatePrivateEventUserFromPrivateEventDto>? privateEventUsers;

  CreatePrivateEventDto({
    required this.title,
    required this.coverImage,
    required this.groupchatTo,
    required this.eventDate,
    this.privateEventUsers,
    this.eventEndDate,
    this.description,
    this.eventLocation,
  });

  Map<dynamic, dynamic> toMap() {
    Map<dynamic, dynamic> map = {
      "title": title,
      "eventDate": eventDate.toUtc().toIso8601String(),
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
    if (privateEventUsers != null) {
      map.addAll({
        'privateEventUsers': privateEventUsers!.map((e) => e.toMap()).toList(),
      });
    }
    if (eventEndDate != null) {
      map.addAll({'eventEndDate': eventEndDate!.toUtc().toIso8601String()});
    }

    return map;
  }
}
