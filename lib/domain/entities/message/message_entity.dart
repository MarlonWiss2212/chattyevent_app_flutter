import 'package:chattyevent_app_flutter/domain/entities/message/message_location_entity.dart';
import 'package:chattyevent_app_flutter/domain/entities/message/message_to_react_to_entity.dart';

class MessageEntity {
  final String id;
  final String? message;
  final List<String>? fileLinks;
  final String? voiceMessageLink;
  final MessageToReactToEntity? messageToReactTo;
  final String? createdBy;
  final DateTime? updatedAt;
  final DateTime createdAt;
  final String? groupchatTo;
  final String? eventTo;
  final String? userTo;
  final MessageLocationEntity? currentLocation;
  final List<String>? readBy;

  MessageEntity({
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
    this.messageToReactTo,
    this.createdBy,
    this.updatedAt,
  });

  factory MessageEntity.merge({
    required MessageEntity newEntity,
    required MessageEntity oldEntity,
  }) {
    return MessageEntity(
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
      messageToReactTo:
          newEntity.messageToReactTo ?? oldEntity.messageToReactTo,
      createdBy: newEntity.createdBy ?? oldEntity.createdBy,
      createdAt: newEntity.createdAt,
      updatedAt: newEntity.updatedAt ?? oldEntity.updatedAt,
    );
  }
}
