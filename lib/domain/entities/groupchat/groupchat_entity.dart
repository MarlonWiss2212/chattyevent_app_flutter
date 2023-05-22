import 'package:chattyevent_app_flutter/domain/entities/groupchat/groupchat_message.dart';
import 'package:chattyevent_app_flutter/domain/entities/groupchat/groupchat_settings_entity.dart';

class GroupchatEntity {
  final String id;
  final String? title;
  final String? profileImageLink;
  final GroupchatMessageEntity? latestMessage;
  final String? description;
  final String? createdBy;
  final GroupchatSettingsEntity? settings;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  GroupchatEntity({
    required this.id,
    this.title,
    this.settings,
    this.latestMessage,
    this.description,
    this.profileImageLink,
    this.createdBy,
    this.createdAt,
    this.updatedAt,
  });

  factory GroupchatEntity.merge({
    required GroupchatEntity newEntity,
    required GroupchatEntity oldEntity,
  }) {
    return GroupchatEntity(
      id: newEntity.id,
      title: newEntity.title ?? oldEntity.title,
      settings: newEntity.settings ?? oldEntity.settings,
      latestMessage: newEntity.latestMessage ?? oldEntity.latestMessage,
      profileImageLink:
          newEntity.profileImageLink ?? oldEntity.profileImageLink,
      description: newEntity.description ?? oldEntity.description,
      createdBy: newEntity.createdBy ?? oldEntity.createdBy,
      createdAt: newEntity.createdAt ?? oldEntity.createdAt,
      updatedAt: newEntity.updatedAt ?? oldEntity.updatedAt,
    );
  }
}
