import 'package:social_media_app_flutter/domain/entities/groupchat_entity.dart';

class GroupchatModel extends GroupchatEntity {
  GroupchatModel({
    required String id,
    String? title,
    String? profileImageLink,
    dynamic users,
    dynamic leftUsers,
    String? description,
    String? chatColorCode,
    String? createdBy,
    String? createdAt,
  }) : super(
          id: id,
          title: title,
          profileImageLink: profileImageLink,
          users: users,
          leftUsers: leftUsers,
          description: description,
          chatColorCode: chatColorCode,
          createdAt: createdAt,
          createdBy: createdBy,
        );

  factory GroupchatModel.fromJson(Map<String, dynamic> json) {
    return GroupchatModel(
      id: json['_id'],
      title: json['title'],
      profileImageLink: json['profileImageLink'],
      users: json["users"],
      leftUsers: json["leftUsers"],
      description: json["description"],
      chatColorCode: json["chatColorCode"],
      createdBy: json["createdBy"],
      createdAt: json["createdAt"],
    );
  }
}
