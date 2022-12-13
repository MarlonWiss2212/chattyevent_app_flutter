import 'package:social_media_app_flutter/domain/entities/message/message_emoji_reaction_entity.dart';

class MessageEntity {
  final String id;
  final String? message;
  final String? fileLink;
  final String? groupchatTo;
  final String? messageToReactTo;
  final List<MessageEmojiReactionEntity> emojiReactions;
  final String? createdBy;
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
  });
}
