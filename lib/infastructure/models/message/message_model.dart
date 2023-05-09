import 'package:chattyevent_app_flutter/domain/entities/message/message_entity.dart';

class MessageModel extends MessageEntity {
  MessageModel({
    required String id,
    String? message,
    String? fileLink,
    String? messageToReactTo,
    String? createdBy,
    required DateTime createdAt,
    DateTime? updatedAt,
  }) : super(
          id: id,
          message: message,
          fileLink: fileLink,
          messageToReactTo: messageToReactTo,
          createdAt: createdAt,
          updatedAt: updatedAt,
          createdBy: createdBy,
        );

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    final createdAt = DateTime.parse(json["createdAt"]).toLocal();

    final updatedAt = json["updatedAt"] != null
        ? DateTime.parse(json["updatedAt"]).toLocal()
        : null;

    return MessageModel(
      id: json['_id'],
      message: json['message'],
      fileLink: json['fileLink'],
      messageToReactTo: json["messageToReactTo"],
      createdBy: json["createdBy"],
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
