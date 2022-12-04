import 'package:social_media_app_flutter/domain/entities/message/message_emoji_reaction_entity.dart';

class MessageEmojiReactionModel extends MessageEmojiReactionEntity {
  MessageEmojiReactionModel({
    required String id,
    String? emoji,
    String? createdAt,
    String? createdBy,
  }) : super(id: id, emoji: emoji, createdAt: createdAt, createdBy: createdBy);

  factory MessageEmojiReactionModel.fromJson(Map<String, dynamic> json) {
    return MessageEmojiReactionModel(
      id: json['_id'],
      emoji: json['emoji'],
      createdBy: json["createdBy"],
      createdAt: json["createdAt"],
    );
  }
}
