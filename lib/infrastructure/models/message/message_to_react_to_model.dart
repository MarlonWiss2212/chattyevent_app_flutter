import 'package:chattyevent_app_flutter/core/enums/message/message_type_enum.dart';
import 'package:chattyevent_app_flutter/domain/entities/message/message_location_entity.dart';
import 'package:chattyevent_app_flutter/domain/entities/message/message_to_react_to_entity.dart';
import 'package:chattyevent_app_flutter/infrastructure/models/message/message_location_model.dart';

class MessageToReactToModel extends MessageToReactToEntity {
  MessageToReactToModel({
    required String id,
    String? message,
    String? typeActionAffectedUserId,
    MessageTypeEnum? type,
    List<String>? fileLinks,
    String? messageToReactToId,
    required String createdBy,
    String? groupchatTo,
    String? eventTo,
    String? userTo,
    required DateTime createdAt,
    MessageLocationEntity? currentLocation,
    required List<String> readBy,
    String? voiceMessageLink,
    required DateTime updatedAt,
  }) : super(
          id: id,
          readBy: readBy,
          currentLocation: currentLocation,
          typeActionAffectedUserId: typeActionAffectedUserId,
          type: type,
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

    return MessageToReactToModel(
      id: json['_id'],
      message: json['message'],
      typeActionAffectedUserId: json['typeActionAffectedUserId'],
      type: json['type'] != null
          ? MessageTypeEnumExtension.fromValue(json['type'])
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
