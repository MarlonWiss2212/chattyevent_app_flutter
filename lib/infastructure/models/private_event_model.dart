import 'package:social_media_app_flutter/domain/entities/private_event_entity.dart';

class PrivateEventModel extends PrivateEventEntity {
  PrivateEventModel({
    required String id,
    String? title,
    String? coverImageLink,
    List<String>? usersThatWillBeThere,
    List<String>? usersThatWillNotBeThere,
    required DateTime eventDate,
    String? connectedGroupchat,
    String? createdBy,
    DateTime? createdAt,
  }) : super(
          id: id,
          title: title,
          coverImageLink: coverImageLink,
          usersThatWillBeThere: usersThatWillBeThere,
          usersThatWillNotBeThere: usersThatWillNotBeThere,
          eventDate: eventDate,
          connectedGroupchat: connectedGroupchat,
          createdAt: createdAt,
          createdBy: createdBy,
        );

  factory PrivateEventModel.fromJson(Map<String, dynamic> json) {
    final createdAt = json["createdAt"] != null
        ? DateTime.parse(json["createdAt"]).toLocal()
        : null;

    List<String> usersThatWillBeThere = [];
    if (json["usersThatWillBeThere"] != null) {
      for (final user in json["usersThatWillBeThere"]) {
        usersThatWillBeThere.add(user.toString());
      }
    }

    List<String> usersThatWillNotBeThere = [];
    if (json["usersThatWillNotBeThere"] != null) {
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
      eventDate: DateTime.parse(json["eventDate"]).toLocal(),
      connectedGroupchat: json["connectedGroupchat"],
      createdBy: json["createdBy"],
      createdAt: createdAt,
    );
  }
}
