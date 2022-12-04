import 'package:social_media_app_flutter/domain/entities/groupchat/groupchat_entity.dart';
import 'package:social_media_app_flutter/domain/entities/groupchat/groupchat_left_user_entity.dart';
import 'package:social_media_app_flutter/domain/entities/groupchat/groupchat_user_entity.dart';
import 'package:social_media_app_flutter/domain/entities/user_entity.dart';
import 'package:social_media_app_flutter/infastructure/models/groupchat/groupchat_left_user_model.dart';
import 'package:social_media_app_flutter/infastructure/models/groupchat/groupchat_user_model.dart';

class GroupchatModel extends GroupchatEntity {
  GroupchatModel({
    required String id,
    String? title,
    String? profileImageLink,
    required List<GroupchatUserEntity> users,
    required List<GroupchatLeftUserEntity> leftUsers,
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
    List<GroupchatUserEntity> users = [];
    if (json["users"] != null) {
      for (final user in json["users"]) {
        users.add(GroupchatUserModel.fromJson(user));
      }
    }

    List<GroupchatLeftUserEntity> leftUsers = [];
    if (json["leftUsers"] != null) {
      for (final user in json["leftUsers"]) {
        leftUsers.add(GroupchatLeftUserModel.fromJson(user));
      }
    }

    return GroupchatModel(
      id: json['_id'],
      title: json['title'],
      profileImageLink: json['profileImageLink'],
      users: users,
      leftUsers: leftUsers,
      description: json["description"],
      chatColorCode: json["chatColorCode"],
      createdBy: json["createdBy"],
      createdAt: json["createdAt"],
    );
  }
}
