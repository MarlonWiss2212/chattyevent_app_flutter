import 'package:chattyevent_app_flutter/core/utils/encryption_utils.dart';
import 'package:chattyevent_app_flutter/domain/entities/groupchat/groupchat_message.dart';

class GroupchatMessageModel extends GroupchatMessageEntity {
  GroupchatMessageModel({
    required String id,
    String? message,
    List<String>? fileLinks,
    String? messageToReactTo,
    String? createdBy,
    required DateTime createdAt,
    String? groupchatTo,
    DateTime? updatedAt,
  }) : super(
          id: id,
          message: message,
          fileLinks: fileLinks,
          messageToReactTo: messageToReactTo,
          createdAt: createdAt,
          updatedAt: updatedAt,
          groupchatTo: groupchatTo,
          createdBy: createdBy,
        );

  factory GroupchatMessageModel.fromJson(Map<String, dynamic> json) {
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

    return GroupchatMessageModel(
      id: json['_id'],
      message: json['message'] != null
          ? EncryptionUtils.decrypt(encryptedText: json["message"])
          : null,
      fileLinks: fileLinks,
      messageToReactTo: json["messageToReactTo"],
      groupchatTo: json["groupchatTo"],
      createdBy: json["createdBy"],
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
