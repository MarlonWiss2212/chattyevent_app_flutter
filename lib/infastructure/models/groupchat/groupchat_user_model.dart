import 'package:social_media_app_flutter/domain/entities/groupchat/groupchat_user_entity.dart';

class GroupchatUserModel extends GroupchatUserEntity {
  GroupchatUserModel({
    required String id,
    String? userId,
    bool? admin,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? usernameForChat,
  }) : super(
          id: id,
          userId: userId,
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
      userId: json['userId'],
      admin: json['admin'],
      createdAt: createdAt,
      updatedAt: updatedAt,
      usernameForChat: json["usernameForChat"],
    );
  }
}
