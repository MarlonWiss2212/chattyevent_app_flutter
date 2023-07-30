import 'dart:io';
import 'package:chattyevent_app_flutter/core/utils/encryption_utils.dart';
import 'package:chattyevent_app_flutter/infastructure/dto/message/create_message_location_dto.dart';

class CreateMessageDto {
  final String message;
  final String? messageToReactTo;
  final String? groupchatTo;
  final String? eventTo;
  final CreateMessageLocationDto? currentLocation;
  final String? userTo;
  // TODO: multiple files
  final File? file;
  final File? voiceMessage;

  CreateMessageDto({
    required this.message,
    this.groupchatTo,
    this.currentLocation,
    this.userTo,
    this.eventTo,
    this.file,
    this.voiceMessage,
    this.messageToReactTo,
  });

  Map toMap() {
    Map<dynamic, dynamic> map = {};
    map.addAll({
      'message': EncryptionUtils.encrypt(text: message),
    });

    if (currentLocation != null) {
      map.addAll({"currentLocation": currentLocation!.toMap()});
    }

    if (messageToReactTo != null) {
      map.addAll({'messageToReactTo': messageToReactTo});
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
