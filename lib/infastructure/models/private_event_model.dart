import 'package:social_media_app_flutter/domain/entities/private_event_entity.dart';

class PrivateEventModel extends PrivateEventEntity {
  PrivateEventModel({
    required String id,
    String? title,
    String? coverImageLink,
    List<String>? usersThatWillBeThere,
    List<String>? usersThatWillNotBeThere,
    String? eventDate,
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
    return PrivateEventModel(
      id: json['_id'],
      title: json['title'],
      coverImageLink: json['coverImageLink'],
      usersThatWillBeThere: json["usersThatWillBeThere"],
      usersThatWillNotBeThere: json["usersThatWillNotBeThere"],
      eventDate: json["eventDate"],
      connectedGroupchat: json["connectedGroupchat"],
      createdBy: json["createdBy"],
      createdAt: createdAt,
    );
  }
}
