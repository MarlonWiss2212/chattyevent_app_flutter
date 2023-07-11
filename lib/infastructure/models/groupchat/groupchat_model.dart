import 'package:chattyevent_app_flutter/domain/entities/groupchat/groupchat_entity.dart';
import 'package:chattyevent_app_flutter/domain/entities/groupchat/groupchat_permissions_entity.dart';
import 'package:chattyevent_app_flutter/domain/entities/message/message_entity.dart';
import 'package:chattyevent_app_flutter/infastructure/models/groupchat/groupchat_permissions_model.dart';
import 'package:chattyevent_app_flutter/infastructure/models/message/message_model.dart';

class GroupchatModel extends GroupchatEntity {
  GroupchatModel({
    required String id,
    String? title,
    String? profileImageLink,
    MessageEntity? latestMessage,
    GroupchatPermissionsEntity? permissions,
    String? description,
    String? createdBy,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super(
          id: id,
          title: title,
          profileImageLink: profileImageLink,
          latestMessage: latestMessage,
          description: description,
          permissions: permissions,
          createdAt: createdAt,
          createdBy: createdBy,
          updatedAt: updatedAt,
        );

  factory GroupchatModel.fromJson(Map<String, dynamic> json) {
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
      permissions: json["permissions"] != null
          ? GroupchatPermissionsModel.fromJson(json["permissions"])
          : null,
      latestMessage: json["latestMessage"] != null
          ? MessageModel.fromJson(json["latestMessage"])
          : null,
      description: json["description"],
      createdBy: json["createdBy"],
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
