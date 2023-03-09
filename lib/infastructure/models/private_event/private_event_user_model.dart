import 'package:social_media_app_flutter/domain/entities/private_event/private_event_user_entity.dart';

class PrivateEventUserModel extends PrivateEventUserEntity {
  PrivateEventUserModel({
    required String id,
    String? userId,
    String? privateEventTo,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? status,
  }) : super(
          id: id,
          userId: userId,
          privateEventTo: privateEventTo,
          updatedAt: updatedAt,
          createdAt: createdAt,
          status: status,
        );

  factory PrivateEventUserModel.fromJson(Map<String, dynamic> json) {
    final createdAt = json["createdAt"] != null
        ? DateTime.parse(json["createdAt"]).toLocal()
        : null;

    final updatedAt = json["updatedAt"] != null
        ? DateTime.parse(json["updatedAt"]).toLocal()
        : null;

    return PrivateEventUserModel(
      id: json['_id'],
      userId: json['userId'],
      privateEventTo: json['privateEventTo'],
      createdAt: createdAt,
      updatedAt: updatedAt,
      status: json["status"],
    );
  }
}
