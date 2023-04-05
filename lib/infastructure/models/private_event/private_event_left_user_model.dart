import 'package:social_media_app_flutter/domain/entities/private_event/private_event_left_user_entity.dart';

class PrivateEventLeftUserModel extends PrivateEventLeftUserEntity {
  PrivateEventLeftUserModel({
    required String id,
    String? userId,
    String? privateEventTo,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super(
          id: id,
          userId: userId,
          privateEventTo: privateEventTo,
          updatedAt: updatedAt,
          createdAt: createdAt,
        );

  factory PrivateEventLeftUserModel.fromJson(Map<String, dynamic> json) {
    final createdAt = json["createdAt"] != null
        ? DateTime.parse(json["createdAt"]).toLocal()
        : null;

    final updatedAt = json["updatedAt"] != null
        ? DateTime.parse(json["updatedAt"]).toLocal()
        : null;

    return PrivateEventLeftUserModel(
      id: json['_id'],
      userId: json['userId'],
      privateEventTo: json['privateEventTo'],
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
