import 'package:social_media_app_flutter/domain/entities/groupchat/groupchat_left_user_entity.dart';
import 'package:social_media_app_flutter/domain/entities/groupchat/groupchat_user_entity.dart';
import 'package:social_media_app_flutter/domain/entities/message/message_entity.dart';

class GroupchatEntity {
  final String id;
  final String? title;
  final String? profileImageLink;
  final List<GroupchatUserEntity>? users;
  final List<GroupchatLeftUserEntity>? leftUsers;
  final List<MessageEntity>? messages;
  final String? description;
  final String? createdBy;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  GroupchatEntity({
    required this.id,
    this.title,
    this.messages,
    this.description,
    this.profileImageLink,
    this.users,
    this.leftUsers,
    this.createdBy,
    this.createdAt,
    this.updatedAt,
  });

  factory GroupchatEntity.merge({
    required GroupchatEntity newEntity,
    required GroupchatEntity oldEntity,
  }) {
    List<GroupchatUserEntity>? users = [];
    if (newEntity.users != null) {
      for (final newUser in newEntity.users!) {
        if (oldEntity.users != null) {
          final oldUser = oldEntity.users!.firstWhere(
            (element) => element.id == newUser.id,
            orElse: () => GroupchatUserEntity(id: ""),
          );
          users.add(
            GroupchatUserEntity.merge(newEntity: newUser, oldEntity: oldUser),
          );
        } else {
          users.add(newUser);
        }
      }
    } else {
      users = oldEntity.users;
    }

    List<GroupchatLeftUserEntity>? leftUsers = [];
    if (newEntity.leftUsers != null) {
      for (final newLeftUser in newEntity.leftUsers!) {
        if (oldEntity.leftUsers != null) {
          final oldLeftUser = oldEntity.leftUsers!.firstWhere(
            (element) => element.id == newLeftUser.id,
            orElse: () => GroupchatLeftUserEntity(id: ""),
          );
          leftUsers.add(
            GroupchatLeftUserEntity.merge(
              newEntity: newLeftUser,
              oldEntity: oldLeftUser,
            ),
          );
        } else {
          leftUsers.add(newLeftUser);
        }
      }
    } else {
      users = oldEntity.users;
    }

    List<MessageEntity>? messages = [];
    if (newEntity.messages != null) {
      for (final newMessage in newEntity.messages!) {
        if (oldEntity.messages != null) {
          final oldMessage = oldEntity.messages!.firstWhere(
            (element) => element.id == newMessage.id,
            orElse: () => MessageEntity(id: "", emojiReactions: []),
          );
          messages.add(
            MessageEntity.merge(newEntity: newMessage, oldEntity: oldMessage),
          );
        } else {
          messages.add(newMessage);
        }
      }
    } else {
      messages = oldEntity.messages;
    }

    return GroupchatEntity(
      id: newEntity.id,
      title: newEntity.title ?? oldEntity.title,
      profileImageLink:
          newEntity.profileImageLink ?? oldEntity.profileImageLink,
      users: users,
      messages: messages,
      leftUsers: leftUsers,
      description: newEntity.description ?? oldEntity.description,
      createdBy: newEntity.createdBy ?? oldEntity.createdBy,
      createdAt: newEntity.createdAt ?? oldEntity.createdAt,
      updatedAt: newEntity.updatedAt ?? oldEntity.updatedAt,
    );
  }
}
