import 'package:social_media_app_flutter/domain/entities/groupchat/groupchat_entity.dart';
import 'package:social_media_app_flutter/domain/entities/groupchat/groupchat_left_user_entity.dart';
import 'package:social_media_app_flutter/domain/entities/groupchat/groupchat_user_entity.dart';
import 'package:social_media_app_flutter/infastructure/models/groupchat/groupchat_left_user_model.dart';
import 'package:social_media_app_flutter/infastructure/models/groupchat/groupchat_user_model.dart';

class GroupchatModel extends GroupchatEntity {
  GroupchatModel({
    required String id,
    String? title,
    String? profileImageLink,
    List<GroupchatUserEntity>? users,
    List<GroupchatLeftUserEntity>? leftUsers,
    String? description,
    String? createdBy,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super(
          id: id,
          title: title,
          profileImageLink: profileImageLink,
          users: users,
          leftUsers: leftUsers,
          description: description,
          createdAt: createdAt,
          createdBy: createdBy,
          updatedAt: updatedAt,
        );

  factory GroupchatModel.fromJson(Map<String, dynamic> json) {
    List<GroupchatUserEntity>? users;
    if (json["users"] != null) {
      users = [];
      for (final user in json["users"]) {
        users.add(GroupchatUserModel.fromJson(user));
      }
    }

    List<GroupchatLeftUserEntity>? leftUsers;
    if (json["leftUsers"] != null) {
      leftUsers = [];
      for (final user in json["leftUsers"]) {
        leftUsers.add(GroupchatLeftUserModel.fromJson(user));
      }
    }

    final createdAt = json["createdAt"] != null
        ? DateTime.parse(json["createdAt"]).toLocal()
        : null;

    final updatedAt = json["updatedAt"] != null
        ? DateTime.parse(json["updatedAt"]).toLocal()
        : null;

    return GroupchatModel(
      id: json['_id'],
      title: json['title'],
      profileImageLink: json['profileImageLink'],
      users: users,
      leftUsers: leftUsers,
      description: json["description"],
      createdBy: json["createdBy"],
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
