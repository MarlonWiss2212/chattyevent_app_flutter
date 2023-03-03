import 'package:social_media_app_flutter/domain/entities/groupchat/groupchat_user_entity.dart';

class GroupchatUserModel extends GroupchatUserEntity {
  GroupchatUserModel({
    required String id,
    String? authId,
    bool? admin,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? usernameForChat,
  }) : super(
          id: id,
          authId: authId,
          admin: admin,
          createdAt: createdAt,
          updatedAt: updatedAt,
          usernameForChat: usernameForChat,
        );

  factory GroupchatUserModel.fromJson(Map<String, dynamic> json) {
    final createdAt = json["createdAt"] != null
        ? DateTime.parse(json["createdAt"]).toLocal()
        : null;

    final updatedAt = json["updatedAt"] != null
        ? DateTime.parse(json["updatedAt"]).toLocal()
        : null;

    return GroupchatUserModel(
      id: json["_id"],
      authId: json['authId'],
      admin: json['admin'],
      createdAt: createdAt,
      updatedAt: updatedAt,
      usernameForChat: json["usernameForChat"],
    );
  }
}
