import 'dart:io';
import 'package:chattyevent_app_flutter/infrastructure/dto/message/create_message_location_dto.dart';

class CreateMessageDto {
  final String? message;
  final String? messageToReactToId;
  final String? groupchatTo;
  final String? eventTo;
  final CreateMessageLocationDto? currentLocation;
  final String? userTo;
  // TODO: multiple files
  final File? file;
  final File? voiceMessage;

  CreateMessageDto({
    this.message,
    this.groupchatTo,
    this.currentLocation,
    this.userTo,
    this.eventTo,
    this.file,
    this.voiceMessage,
    this.messageToReactToId,
  });

  Map toMap() {
    Map<dynamic, dynamic> map = {};
    if (message != null) {
      map.addAll({'message': message});
    }

    if (currentLocation != null) {
      map.addAll({"currentLocation": currentLocation!.toMap()});
    }

    if (messageToReactToId != null) {
      map.addAll({'messageToReactToId': messageToReactToId});
    }
    if (groupchatTo != null) {
      map.addAll({'groupchatTo': groupchatTo});
    }
    if (eventTo != null) {
      map.addAll({'eventTo': eventTo});
    }
    if (userTo != null) {
      map.addAll({'userTo': userTo});
    }

    return map;
  }
}
