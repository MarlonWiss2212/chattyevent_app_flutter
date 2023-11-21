import 'package:chattyevent_app_flutter/core/enums/message/message_type_enum.dart';
import 'package:chattyevent_app_flutter/domain/entities/message/message_entity.dart';
import 'package:chattyevent_app_flutter/domain/entities/message/message_location_entity.dart';
import 'package:chattyevent_app_flutter/domain/entities/message/message_to_react_to_entity.dart';
import 'package:chattyevent_app_flutter/infrastructure/models/message/message_location_model.dart';
import 'package:chattyevent_app_flutter/infrastructure/models/message/message_to_react_to_model.dart';

class MessageModel extends MessageEntity {
  MessageModel({
    required String id,
    String? message,
    String? typeActionAffectedUserId,
    MessageTypeEnum? type,
    List<String>? fileLinks,
    MessageToReactToEntity? messageToReactTo,
    required String createdBy,
    String? groupchatTo,
    String? eventTo,
    String? userTo,
    required DateTime createdAt,
    MessageLocationEntity? currentLocation,
    required List<String> readBy,
    String? voiceMessageLink,
    required bool deleted,
    required DateTime updatedAt,
  }) : super(
          id: id,
          deleted: deleted,
          readBy: readBy,
          typeActionAffectedUserId: typeActionAffectedUserId,
          type: type,
          currentLocation: currentLocation,
          message: message,
          fileLinks: fileLinks,
          voiceMessageLink: voiceMessageLink,
          groupchatTo: groupchatTo,
          userTo: userTo,
          eventTo: eventTo,
          messageToReactTo: messageToReactTo,
          createdAt: createdAt,
          updatedAt: updatedAt,
          createdBy: createdBy,
        );

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    final DateTime createdAt = DateTime.parse(json["createdAt"]).toLocal();
    final DateTime updatedAt = DateTime.parse(json["updatedAt"]).toLocal();

    List<String>? fileLinks;
    if (json['fileLinks'] != null) {
      fileLinks ??= [];
      for (final link in json['fileLinks']) {
        fileLinks.add(link);
      }
    }

    List<String> readBy = [];
    for (final readId in json["readBy"]) {
      readBy.add(readId);
    }

    return MessageModel(
      id: json['_id'],
      deleted: json["deleted"],
      message: json['message'],
      fileLinks: fileLinks,
      typeActionAffectedUserId: json['typeActionAffectedUserId'],
      type: json['type'] != null
          ? MessageTypeEnumExtension.fromValue(json['type'])
          : null,
      voiceMessageLink: json['voiceMessageLink'],
      currentLocation: json['currentLocation'] != null
          ? MessageLocationModel.fromJson(json['currentLocation'])
          : null,
      readBy: readBy,
      messageToReactTo: json["messageToReactTo"] != null
          ? MessageToReactToModel.fromJson(json["messageToReactTo"])
          : null,
      createdBy: json["createdBy"],
      groupchatTo: json['groupchatTo'],
      userTo: json['userTo'],
      eventTo: json['eventTo'],
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
