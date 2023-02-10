import 'package:social_media_app_flutter/domain/entities/message/message_emoji_reaction_entity.dart';

class MessageEntity {
  final String id;
  final String? message;
  final String? fileLink;
  final String? groupchatTo;
  final String? messageToReactTo;
  final List<MessageEmojiReactionEntity>? emojiReactions;
  final String? createdBy;
  final DateTime? updatedAt;
  final DateTime? createdAt;

  MessageEntity({
    required this.id,
    this.message,
    this.fileLink,
    this.groupchatTo,
    this.messageToReactTo,
    required this.emojiReactions,
    this.createdBy,
    this.createdAt,
    this.updatedAt,
  });

  factory MessageEntity.merge({
    required MessageEntity newEntity,
    required MessageEntity oldEntity,
  }) {
    return MessageEntity(
      id: newEntity.id,
      message: newEntity.message ?? oldEntity.message,
      fileLink: newEntity.fileLink ?? oldEntity.fileLink,
      groupchatTo: newEntity.groupchatTo ?? oldEntity.groupchatTo,
      messageToReactTo:
          newEntity.messageToReactTo ?? oldEntity.messageToReactTo,
      emojiReactions: newEntity.emojiReactions ?? oldEntity.emojiReactions,
      createdBy: newEntity.createdBy ?? oldEntity.createdBy,
      createdAt: newEntity.createdAt ?? oldEntity.createdAt,
      updatedAt: newEntity.updatedAt ?? oldEntity.updatedAt,
    );
  }
}
