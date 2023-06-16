import 'package:chattyevent_app_flutter/core/utils/encryption_utils.dart';
import 'package:chattyevent_app_flutter/domain/entities/message/message_entity.dart';

class MessageModel extends MessageEntity {
  MessageModel({
    required String id,
    String? message,
    List<String>? fileLinks,
    String? messageToReactTo,
    String? createdBy,
    required DateTime createdAt,
    DateTime? updatedAt,
  }) : super(
          id: id,
          message: message,
          fileLinks: fileLinks,
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

    List<String>? fileLinks;
    if (json['fileLinks'] != null) {
      fileLinks ??= [];
      for (final link in json['fileLinks']) {
        fileLinks.add(link);
      }
    }

    return MessageModel(
      id: json['_id'],
      message: json['message'] != null
          ? EncryptionUtils.decrypt(encryptedText: json['message'])
          : null,
      fileLinks: fileLinks,
      messageToReactTo: json["messageToReactTo"],
      createdBy: json["createdBy"],
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
