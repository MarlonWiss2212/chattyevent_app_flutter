import 'package:social_media_app_flutter/domain/entities/private_event/private_event_entity.dart';
import 'package:social_media_app_flutter/domain/entities/private_event/private_event_location_entity.dart';
import 'package:social_media_app_flutter/infastructure/models/private_event/private_event_location_model.dart';

class PrivateEventModel extends PrivateEventEntity {
  PrivateEventModel({
    required String id,
    String? title,
    String? coverImageLink,
    List<String>? usersThatWillBeThere,
    List<String>? usersThatWillNotBeThere,
    DateTime? eventDate,
    String? connectedGroupchat,
    String? createdBy,
    DateTime? createdAt,
    DateTime? updatedAt,
    PrivateEventLocationEntity? eventLocation,
  }) : super(
          id: id,
          title: title,
          coverImageLink: coverImageLink,
          usersThatWillBeThere: usersThatWillBeThere,
          usersThatWillNotBeThere: usersThatWillNotBeThere,
          eventDate: eventDate,
          connectedGroupchat: connectedGroupchat,
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

    final eventDate = json["eventDate"] != null
        ? DateTime.parse(json["eventDate"]).toLocal()
        : null;

    List<String>? usersThatWillBeThere;
    if (json["usersThatWillBeThere"] != null) {
      usersThatWillBeThere = [];
      for (final user in json["usersThatWillBeThere"]) {
        usersThatWillBeThere.add(user.toString());
      }
    }

    List<String>? usersThatWillNotBeThere;
    if (json["usersThatWillNotBeThere"] != null) {
      usersThatWillNotBeThere = [];
      for (final user in json["usersThatWillNotBeThere"]) {
        usersThatWillNotBeThere.add(user.toString());
      }
    }

    return PrivateEventModel(
      id: json['_id'],
      title: json['title'],
      coverImageLink: json['coverImageLink'],
      usersThatWillBeThere: usersThatWillBeThere,
      usersThatWillNotBeThere: usersThatWillNotBeThere,
      eventDate: eventDate,
      connectedGroupchat: json["connectedGroupchat"],
      createdBy: json["createdBy"],
      createdAt: createdAt,
      updatedAt: updatedAt,
      eventLocation: json["eventLocation"] != null
          ? PrivateEventLocationModel.fromJson(json["eventLocation"])
          : null,
    );
  }
}
