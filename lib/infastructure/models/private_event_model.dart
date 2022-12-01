import 'package:social_media_app_flutter/domain/entities/private_event_entity.dart';

class PrivateEventModel extends PrivateEventEntity {
  PrivateEventModel({
    required String id,
    String? title,
    String? coverImageLink,
    dynamic usersThatWillBeThere,
    dynamic usersThatWillNotBeThere,
    String? eventDate,
    String? connectedGroupchat,
    String? createdBy,
    String? createdAt,
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
    return PrivateEventModel(
      id: json['_id'],
      title: json['title'],
      coverImageLink: json['coverImageLink'],
      usersThatWillBeThere: json["usersThatWillBeThere"],
      usersThatWillNotBeThere: json["usersThatWillNotBeThere"],
      eventDate: json["eventDate"],
      connectedGroupchat: json["connectedGroupchat"],
      createdBy: json["createdBy"],
      createdAt: json["createdAt"],
    );
  }
}
