import 'package:social_media_app_flutter/domain/entities/groupchat/groupchat_user_entity.dart';

class GroupchatUserModel extends GroupchatUserEntity {
  GroupchatUserModel({
    required String userId,
    bool? admin,
    String? joinedAt,
  }) : super(
          userId: userId,
          admin: admin,
          joinedAt: joinedAt,
        );

  factory GroupchatUserModel.fromJson(Map<String, dynamic> json) {
    return GroupchatUserModel(
      userId: json['userId'],
      admin: json['admin'],
      joinedAt: json['joinedAt'],
    );
  }
}
