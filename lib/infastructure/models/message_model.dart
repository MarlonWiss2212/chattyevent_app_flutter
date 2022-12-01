import 'package:social_media_app_flutter/domain/entities/message_entity.dart';

class MessageModel extends MessageEntity {
  MessageModel({
    required String id,
    String? message,
    String? fileLink,
    String? groupchatTo,
    String? messageToReactTo,
    dynamic emojiReactions,
    String? createdBy,
    String? createdAt,
  }) : super(
          id: id,
          message: message,
          fileLink: fileLink,
          groupchatTo: groupchatTo,
          messageToReactTo: messageToReactTo,
          emojiReactions: emojiReactions,
          createdAt: createdAt,
          createdBy: createdBy,
        );

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      id: json['_id'],
      message: json['message'],
      fileLink: json['fileLink'],
      groupchatTo: json["groupchatTo"],
      messageToReactTo: json["messageToReactTo"],
      emojiReactions: json["emojiReactions"],
      createdBy: json["createdBy"],
      createdAt: json["createdAt"],
    );
  }
}
