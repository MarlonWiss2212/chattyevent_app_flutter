import 'package:chattyevent_app_flutter/domain/entities/message/message_emoji_reaction_entity.dart';
import 'package:chattyevent_app_flutter/domain/entities/message/message_entity.dart';
import 'package:chattyevent_app_flutter/infastructure/models/message/message_emoji_reaction_model.dart';

class MessageModel extends MessageEntity {
  MessageModel({
    required String id,
    String? message,
    String? fileLink,
    String? groupchatTo,
    String? messageToReactTo,
    List<MessageEmojiReactionEntity>? emojiReactions,
    String? createdBy,
    required DateTime createdAt,
    DateTime? updatedAt,
  }) : super(
          id: id,
          message: message,
          fileLink: fileLink,
          groupchatTo: groupchatTo,
          messageToReactTo: messageToReactTo,
          emojiReactions: emojiReactions,
          createdAt: createdAt,
          updatedAt: updatedAt,
          createdBy: createdBy,
        );

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    List<MessageEmojiReactionEntity>? messageEmojiReactions;
    if (json["emojiReactions"] != null) {
      messageEmojiReactions = [];
      for (final messageEmojiReaction in json["emojiReactions"]) {
        messageEmojiReactions.add(
          MessageEmojiReactionModel.fromJson(messageEmojiReaction),
        );
      }
    }

    final createdAt = DateTime.parse(json["createdAt"]).toLocal();

    final updatedAt = json["updatedAt"] != null
        ? DateTime.parse(json["updatedAt"]).toLocal()
        : null;

    return MessageModel(
      id: json['_id'],
      message: json['message'],
      fileLink: json['fileLink'],
      groupchatTo: json["groupchatTo"],
      messageToReactTo: json["messageToReactTo"],
      emojiReactions: messageEmojiReactions,
      createdBy: json["createdBy"],
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
