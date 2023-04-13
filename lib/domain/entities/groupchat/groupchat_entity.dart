import 'package:social_media_app_flutter/domain/entities/message/message_entity.dart';

class GroupchatEntity {
  final String id;
  final String? title;
  final String? profileImageLink;
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
    this.createdBy,
    this.createdAt,
    this.updatedAt,
  });

  factory GroupchatEntity.merge({
    required GroupchatEntity newEntity,
    required GroupchatEntity oldEntity,
    bool mergeChatSetMessagesFromOldEntity = false,
  }) {
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
      messages: messages,
      description: newEntity.description ?? oldEntity.description,
      createdBy: newEntity.createdBy ?? oldEntity.createdBy,
      createdAt: newEntity.createdAt ?? oldEntity.createdAt,
      updatedAt: newEntity.updatedAt ?? oldEntity.updatedAt,
    );
  }
}
