import 'package:chattyevent_app_flutter/domain/entities/groupchat/groupchat_entity.dart';
import 'package:chattyevent_app_flutter/domain/entities/groupchat/groupchat_message.dart';
import 'package:chattyevent_app_flutter/domain/entities/groupchat/groupchat_settings_entity.dart';
import 'package:chattyevent_app_flutter/infastructure/models/groupchat/groupchat_message_model.dart';
import 'package:chattyevent_app_flutter/infastructure/models/groupchat/groupchat_settings_model.dart';

class GroupchatModel extends GroupchatEntity {
  GroupchatModel({
    required String id,
    String? title,
    String? profileImageLink,
    GroupchatMessageEntity? latestMessage,
    GroupchatSettingsEntity? settings,
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
          createdAt: createdAt,
          settings: settings,
          createdBy: createdBy,
          updatedAt: updatedAt,
        );

  factory GroupchatModel.fromJson(Map<String, dynamic> json) {
    List<GroupchatMessageEntity>? messages;
    if (json["messages"] != null) {
      messages = [];
      for (final message in json["messages"]) {
        messages.add(GroupchatMessageModel.fromJson(message));
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
      latestMessage: json["latestMessage"] != null
          ? GroupchatMessageModel.fromJson(json["latestMessage"])
          : null,
      description: json["description"],
      createdBy: json["createdBy"],
      settings: json["settings"] != null
          ? GroupchatSettingsModel.fromJson(json["settings"])
          : null,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
