import 'package:chattyevent_app_flutter/domain/entities/groupchat/groupchat_permissions_entity.dart';
import 'package:chattyevent_app_flutter/domain/entities/message/message_entity.dart';

class GroupchatEntity {
  final String id;
  final String? title;
  final String? profileImageLink;
  final MessageEntity? latestMessage;
  final String? description;
  final String? createdBy;
  final GroupchatPermissionsEntity? permissions;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  GroupchatEntity({
    required this.id,
    this.title,
    this.latestMessage,
    this.permissions,
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
      latestMessage: newEntity.latestMessage ?? oldEntity.latestMessage,
      permissions: newEntity.permissions ?? oldEntity.permissions,
      profileImageLink:
          newEntity.profileImageLink ?? oldEntity.profileImageLink,
      description: newEntity.description ?? oldEntity.description,
      createdBy: newEntity.createdBy ?? oldEntity.createdBy,
      createdAt: newEntity.createdAt ?? oldEntity.createdAt,
      updatedAt: newEntity.updatedAt ?? oldEntity.updatedAt,
    );
  }
}
