import 'package:chattyevent_app_flutter/core/enums/message/message_type_enum.dart';
import 'package:chattyevent_app_flutter/domain/entities/message/message_entity.dart';
import 'package:chattyevent_app_flutter/domain/entities/message/message_location_entity.dart';

class MessageToReactToEntity {
  final String id;
  final String? message;
  final String? typeActionAffectedUserId;
  final MessageTypeEnum? type;
  final List<String>? fileLinks;
  final String? voiceMessageLink;
  final String? messageToReactToId;
  final String createdBy;
  final DateTime updatedAt;
  final DateTime createdAt;
  final String? groupchatTo;
  final String? eventTo;
  final String? userTo;
  final MessageLocationEntity? currentLocation;
  final List<String> readBy;

  MessageToReactToEntity({
    required this.id,
    this.type,
    this.typeActionAffectedUserId,
    this.groupchatTo,
    this.eventTo,
    this.currentLocation,
    this.voiceMessageLink,
    this.userTo,
    required this.createdAt,
    required this.readBy,
    this.message,
    this.fileLinks,
    this.messageToReactToId,
    required this.createdBy,
    required this.updatedAt,
  });

  factory MessageToReactToEntity.fromMessageEntity({
    required MessageEntity message,
  }) {
    return MessageToReactToEntity(
      id: message.id,
      type: message.type,
      typeActionAffectedUserId: message.typeActionAffectedUserId,
      voiceMessageLink: message.voiceMessageLink,
      currentLocation: message.currentLocation,
      message: message.message,
      fileLinks: message.fileLinks,
      readBy: message.readBy,
      groupchatTo: message.groupchatTo,
      userTo: message.userTo,
      eventTo: message.eventTo,
      messageToReactToId: message.messageToReactTo?.id,
      createdBy: message.createdBy,
      createdAt: message.createdAt,
      updatedAt: message.updatedAt,
    );
  }
}
