import 'package:social_media_app_flutter/domain/entities/private_event/private_event_user_entity.dart';

class PrivateEventUserModel extends PrivateEventUserEntity {
  PrivateEventUserModel({
    required String id,
    String? authId,
    String? privateEventTo,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isInvitedIndependetFromGroupchat,
    String? status,
  }) : super(
          id: id,
          authId: authId,
          privateEventTo: privateEventTo,
          isInvitedIndependetFromGroupchat: isInvitedIndependetFromGroupchat,
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
      authId: json['authId'],
      privateEventTo: json['privateEventTo'],
      createdAt: createdAt,
      updatedAt: updatedAt,
      isInvitedIndependetFromGroupchat:
          json["isInvitedIndependetFromGroupchat"],
      status: json["status"],
    );
  }
}
