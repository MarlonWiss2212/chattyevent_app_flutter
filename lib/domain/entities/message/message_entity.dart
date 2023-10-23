import 'package:chattyevent_app_flutter/core/enums/message/message_type_enum.dart';
import 'package:chattyevent_app_flutter/domain/entities/message/message_location_entity.dart';
import 'package:chattyevent_app_flutter/domain/entities/message/message_to_react_to_entity.dart';

class MessageEntity {
  final String id;
  final String? message;
  final String? typeActionAffectedUserId;
  final MessageTypeEnum? type;
  final List<String>? fileLinks;
  final String? voiceMessageLink;
  final MessageToReactToEntity? messageToReactTo;
  final String createdBy;
  final DateTime updatedAt;
  final DateTime createdAt;
  final String? groupchatTo;
  final String? eventTo;
  final String? userTo;
  final MessageLocationEntity? currentLocation;
  final List<String> readBy;

  MessageEntity({
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
    this.messageToReactTo,
    required this.createdBy,
    required this.updatedAt,
  });
}
