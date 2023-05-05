import 'dart:io';
import 'package:chattyevent_app_flutter/core/dto/private_event/create_location_private_event_dto.dart';

class UpdatePrivateEventDto {
  final String? title;
  final String? description;
  final String? status;
  final File? updateCoverImage;
  final DateTime? eventDate;
  final DateTime? eventEndDate;
  final CreatePrivateEventLocationDto? eventLocation;

  UpdatePrivateEventDto({
    this.title,
    this.description,
    this.status,
    this.updateCoverImage,
    this.eventDate,
    this.eventEndDate,
    this.eventLocation,
  });

  Map<dynamic, dynamic> toMap() {
    Map<dynamic, dynamic> map = {};

    if (title != null) {
      map.addAll({"title": title});
    }
    if (description != null) {
      map.addAll({"description": description});
    }
    if (status != null) {
      map.addAll({"status": status});
    }
    if (eventDate != null) {
      map.addAll({
        "eventDate": eventDate!.toUtc().toIso8601String(),
      });
    }
    if (eventLocation != null) {
      map.addAll({"eventLocation": eventLocation!.toMap()});
    }
    if (eventEndDate != null) {
      map.addAll({'eventEndDate': eventEndDate!.toUtc().toIso8601String()});
    }

    return map;
  }
}
