import 'package:chattyevent_app_flutter/core/utils/encryption_utils.dart';
import 'package:chattyevent_app_flutter/domain/entities/message/message_location_entity.dart';
import 'package:chattyevent_app_flutter/domain/entities/message/message_to_react_to_entity.dart';
import 'package:chattyevent_app_flutter/infastructure/models/message/message_location_model.dart';

class MessageToReactToModel extends MessageToReactToEntity {
  MessageToReactToModel({
    required String id,
    String? message,
    List<String>? fileLinks,
    String? messageToReactToId,
    String? createdBy,
    String? groupchatTo,
    String? eventTo,
    String? userTo,
    required DateTime createdAt,
    MessageLocationEntity? currentLocation,
    List<String>? readBy,
    String? voiceMessageLink,
    DateTime? updatedAt,
  }) : super(
          id: id,
          readBy: readBy,
          currentLocation: currentLocation,
          message: message,
          fileLinks: fileLinks,
          voiceMessageLink: voiceMessageLink,
          groupchatTo: groupchatTo,
          userTo: userTo,
          eventTo: eventTo,
          messageToReactToId: messageToReactToId,
          createdAt: createdAt,
          updatedAt: updatedAt,
          createdBy: createdBy,
        );

  factory MessageToReactToModel.fromJson(Map<String, dynamic> json) {
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

    List<String>? readBy;
    if (json['readBy'] != null) {
      readBy ??= [];
      for (final readId in json["readBy"]) {
        readBy.add(readId);
      }
    }

    return MessageToReactToModel(
      id: json['_id'],
      message: json['message'] != null
          ? EncryptionUtils.decrypt(encryptedText: json['message'])
          : null,
      fileLinks: fileLinks,
      voiceMessageLink: json['voiceMessageLink'],
      currentLocation: json['currentLocation'] != null
          ? MessageLocationModel.fromJson(json['currentLocation'])
          : null,
      readBy: readBy,
      messageToReactToId: json["messageToReactToId"],
      createdBy: json["createdBy"],
      groupchatTo: json['groupchatTo'],
      userTo: json['userTo'],
      eventTo: json['eventTo'],
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
