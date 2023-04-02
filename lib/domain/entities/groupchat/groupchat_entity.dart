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
    bool mergeChatSetMessagesFromOldEntity = false,
    bool mergeChatSetLeftUsersFromOldEntity = false,
    bool mergeChatSetUsersFromOldEntity = false,
  }) {
    List<GroupchatUserEntity>? users =
        mergeChatSetUsersFromOldEntity ? oldEntity.users : null;
    if (newEntity.users != null) {
      for (final newUser in newEntity.users!) {
        if (users == null) {
          users ??= [];
          users.add(newUser);
          continue;
        }
        final index = users.indexWhere(
          (element) => element.id == newUser.id,
        );
        if (index == -1) {
          users.add(newUser);
        } else {
          users[index] = GroupchatUserEntity.merge(
            newEntity: newUser,
            oldEntity: users[index],
          );
        }
      }
    }

    List<GroupchatLeftUserEntity>? leftUsers =
        mergeChatSetLeftUsersFromOldEntity ? oldEntity.leftUsers : null;
    if (newEntity.leftUsers != null) {
      for (final newLeftUser in newEntity.leftUsers!) {
        if (leftUsers == null) {
          leftUsers ??= [];
          leftUsers.add(newLeftUser);
          continue;
        }
        final index = leftUsers.indexWhere(
          (element) => element.id == newLeftUser.id,
        );
        if (index == -1) {
          leftUsers.add(newLeftUser);
        } else {
          leftUsers[index] = GroupchatLeftUserEntity.merge(
            newEntity: newLeftUser,
            oldEntity: leftUsers[index],
          );
        }
      }
    }

    List<MessageEntity>? messages =
        mergeChatSetMessagesFromOldEntity ? oldEntity.messages : null;
    if (newEntity.messages != null) {
      for (final newMessage in newEntity.messages!) {
        if (messages == null) {
          messages ??= [];
          messages.add(newMessage);
          continue;
        }
        final messageIndex = messages.indexWhere(
          (element) => element.id == newMessage.id,
        );
        if (messageIndex == -1) {
          messages.add(newMessage);
        } else {
          messages[messageIndex] = MessageEntity.merge(
            newEntity: newMessage,
            oldEntity: messages[messageIndex],
          );
        }
      }
    }
    messages?.sort((a, b) => b.createdAt!.compareTo(a.createdAt!));

    return GroupchatEntity(
      id: newEntity.id,
      title: newEntity.title ?? oldEntity.title,
      profileImageLink:
          newEntity.profileImageLink ?? oldEntity.profileImageLink,
      users: users,
      leftUsers: leftUsers,
      description: newEntity.description ?? oldEntity.description,
      createdBy: newEntity.createdBy ?? oldEntity.createdBy,
      createdAt: newEntity.createdAt ?? oldEntity.createdAt,
      updatedAt: newEntity.updatedAt ?? oldEntity.updatedAt,
    );
  }
}
