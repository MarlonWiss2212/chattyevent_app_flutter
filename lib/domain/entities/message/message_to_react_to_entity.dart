import 'package:chattyevent_app_flutter/domain/entities/message/message_entity.dart';
import 'package:chattyevent_app_flutter/domain/entities/message/message_location_entity.dart';

class MessageToReactToEntity {
  final String id;
  final String? message;
  final List<String>? fileLinks;
  final String? voiceMessageLink;
  final String? messageToReactToId;
  final String? createdBy;
  final DateTime? updatedAt;
  final DateTime createdAt;
  final String? groupchatTo;
  final String? eventTo;
  final String? userTo;
  final MessageLocationEntity? currentLocation;
  final List<String>? readBy;

  MessageToReactToEntity({
    required this.id,
    this.groupchatTo,
    this.eventTo,
    this.currentLocation,
    this.voiceMessageLink,
    this.userTo,
    required this.createdAt,
    this.readBy,
    this.message,
    this.fileLinks,
    this.messageToReactToId,
    this.createdBy,
    this.updatedAt,
  });

  factory MessageToReactToEntity.fromMessageEntity({
    required MessageEntity message,
  }) {
    return MessageToReactToEntity(
      id: message.id,
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

  factory MessageToReactToEntity.merge({
    required MessageToReactToEntity newEntity,
    required MessageToReactToEntity oldEntity,
  }) {
    return MessageToReactToEntity(
      id: newEntity.id,
      voiceMessageLink:
          newEntity.voiceMessageLink ?? oldEntity.voiceMessageLink,
      currentLocation: newEntity.currentLocation ?? oldEntity.currentLocation,
      message: newEntity.message ?? oldEntity.message,
      fileLinks: newEntity.fileLinks ?? oldEntity.fileLinks,
      readBy: newEntity.readBy ?? oldEntity.readBy,
      groupchatTo: newEntity.groupchatTo ?? oldEntity.groupchatTo,
      userTo: newEntity.userTo ?? oldEntity.userTo,
      eventTo: newEntity.eventTo ?? oldEntity.eventTo,
      messageToReactToId:
          newEntity.messageToReactToId ?? oldEntity.messageToReactToId,
      createdBy: newEntity.createdBy ?? oldEntity.createdBy,
      createdAt: newEntity.createdAt,
      updatedAt: newEntity.updatedAt ?? oldEntity.updatedAt,
    );
  }
}
