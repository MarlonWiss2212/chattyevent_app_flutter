import 'dart:io';
import 'package:chattyevent_app_flutter/core/enums/private_event/private_event_status_enum.dart';
import 'package:chattyevent_app_flutter/infastructure/dto/private_event/create_location_private_event_dto.dart';
import 'package:chattyevent_app_flutter/infastructure/dto/private_event/update_private_event_permissions_dto.dart';

class UpdatePrivateEventDto {
  final String? title;
  final String? description;
  final PrivateEventStatusEnum? status;
  final File? updateCoverImage;
  final DateTime? eventDate;
  final DateTime? eventEndDate;
  final UpdatePrivateEventPermissionsDto? permissions;
  final CreatePrivateEventLocationDto? eventLocation;
  final bool? removeEventLocation;

  UpdatePrivateEventDto({
    this.title,
    this.description,
    this.status,
    this.updateCoverImage,
    this.permissions,
    this.eventDate,
    this.eventEndDate,
    this.removeEventLocation,
    this.eventLocation,
  });

  Map<dynamic, dynamic> toMap() {
    Map<dynamic, dynamic> map = {};

    if (permissions != null) {
      map.addAll({"permissions": permissions!.toMap()});
    }
    if (title != null) {
      map.addAll({"title": title});
    }
    if (description != null) {
      map.addAll({"description": description});
    }
    if (status != null) {
      map.addAll({"status": status!.value});
    }
    if (eventDate != null) {
      map.addAll({
        "eventDate": eventDate!.toUtc().toIso8601String(),
      });
    }
    if (eventLocation != null) {
      map.addAll({"eventLocation": eventLocation!.toMap()});
    }
    if (removeEventLocation != null) {
      map.addAll({"removeEventLocation": removeEventLocation});
    }
    if (eventEndDate != null) {
      map.addAll({'eventEndDate': eventEndDate!.toUtc().toIso8601String()});
    }

    return map;
  }
}
