import 'package:chattyevent_app_flutter/domain/entities/groupchat/groupchat_message.dart';

class GroupchatMessageModel extends GroupchatMessageEntity {
  GroupchatMessageModel({
    required String id,
    String? message,
    String? fileLink,
    String? messageToReactTo,
    String? createdBy,
    required DateTime createdAt,
    String? groupchatTo,
    DateTime? updatedAt,
  }) : super(
          id: id,
          message: message,
          fileLink: fileLink,
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

    return GroupchatMessageModel(
      id: json['_id'],
      message: json['message'],
      fileLink: json['fileLink'],
      messageToReactTo: json["messageToReactTo"],
      groupchatTo: json["groupchatTo"],
      createdBy: json["createdBy"],
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
