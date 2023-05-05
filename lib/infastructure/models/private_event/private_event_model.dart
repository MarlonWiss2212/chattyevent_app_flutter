import 'package:chattyevent_app_flutter/domain/entities/private_event/private_event_entity.dart';
import 'package:chattyevent_app_flutter/domain/entities/private_event/private_event_location_entity.dart';
import 'package:chattyevent_app_flutter/infastructure/models/private_event/private_event_location_model.dart';

class PrivateEventModel extends PrivateEventEntity {
  PrivateEventModel({
    required String id,
    String? title,
    String? status,
    String? description,
    String? coverImageLink,
    required DateTime eventDate,
    DateTime? eventEndDate,
    String? groupchatTo,
    String? createdBy,
    DateTime? createdAt,
    DateTime? updatedAt,
    PrivateEventLocationEntity? eventLocation,
  }) : super(
          id: id,
          title: title,
          coverImageLink: coverImageLink,
          description: description,
          eventDate: eventDate,
          eventEndDate: eventEndDate,
          status: status,
          groupchatTo: groupchatTo,
          createdAt: createdAt,
          updatedAt: updatedAt,
          createdBy: createdBy,
          eventLocation: eventLocation,
        );

  factory PrivateEventModel.fromJson(Map<String, dynamic> json) {
    final createdAt = json["createdAt"] != null
        ? DateTime.parse(json["createdAt"]).toLocal()
        : null;

    final updatedAt = json["updatedAt"] != null
        ? DateTime.parse(json["updatedAt"]).toLocal()
        : null;

    final eventDate = DateTime.parse(json["eventDate"]).toLocal();

    final eventEndDate = json["eventEndDate"] != null
        ? DateTime.parse(json["eventEndDate"]).toLocal()
        : null;

    return PrivateEventModel(
      id: json['_id'],
      title: json['title'],
      coverImageLink: json['coverImageLink'],
      eventDate: eventDate,
      description: json["description"],
      eventEndDate: eventEndDate,
      status: json["status"],
      groupchatTo: json["groupchatTo"],
      createdBy: json["createdBy"],
      createdAt: createdAt,
      updatedAt: updatedAt,
      eventLocation: json["eventLocation"] != null
          ? PrivateEventLocationModel.fromJson(json["eventLocation"])
          : null,
    );
  }
}
