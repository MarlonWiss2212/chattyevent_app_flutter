import 'dart:io';
import 'package:chattyevent_app_flutter/infrastructure/dto/event/create_event_location_dto.dart';
import 'package:chattyevent_app_flutter/infrastructure/dto/event/create_event_permissions_dto.dart';
import 'package:chattyevent_app_flutter/infrastructure/dto/event/create_private_event_data_dto.dart';
import 'package:chattyevent_app_flutter/infrastructure/dto/event/event_user/create_event_user_from_event_dto.dart';

class CreateEventDto {
  final String title;
  final String? description;
  final File? coverImage;
  final CreatePrivateEventDataDto? privateEventData;
  final CreateEventPermissionsDto? permissions;
  final DateTime eventDate;
  final DateTime? eventEndDate;
  final bool? autoDelete;
  final CreateEventLocationDto? eventLocation;
  final List<CreateEventUserFromEventDto>? eventUsers;

  CreateEventDto({
    required this.title,
    required this.coverImage,
    required this.privateEventData,
    required this.eventDate,
    required this.autoDelete,
    this.permissions,
    this.eventUsers,
    this.eventEndDate,
    this.description,
    this.eventLocation,
  });

  Map<dynamic, dynamic> toMap() {
    Map<dynamic, dynamic> map = {
      "title": title,
      "eventDate": eventDate.toUtc().toIso8601String(),
      "autoDelete": autoDelete
    };
    if (permissions != null) {
      map.addAll({"permissions": permissions!.toMap()});
    }
    if (privateEventData != null) {
      map.addAll({"privateEventData": privateEventData!.toMap()});
    }
    if (eventLocation != null) {
      map.addAll({"eventLocation": eventLocation!.toMap()});
    }
    if (description != null) {
      map.addAll({'description': description});
    }
    if (eventUsers != null) {
      map.addAll({
        'eventUsers': eventUsers!.map((e) => e.toMap()).toList(),
      });
    }
    if (eventEndDate != null) {
      map.addAll({'eventEndDate': eventEndDate!.toUtc().toIso8601String()});
    }

    return map;
  }
}
