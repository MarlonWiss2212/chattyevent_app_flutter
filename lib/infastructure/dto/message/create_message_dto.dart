import 'dart:io';
import 'package:chattyevent_app_flutter/core/utils/encryption_utils.dart';

class CreateMessageDto {
  final String message;
  final String? messageToReactTo;
  final String? groupchatTo;
  final String? privateEventTo;
  final String? userTo;
  // TODO: multiple files
  final File? file;

  CreateMessageDto({
    required this.message,
    this.groupchatTo,
    this.userTo,
    this.privateEventTo,
    this.file,
    this.messageToReactTo,
  });

  Map toMap() {
    Map<dynamic, dynamic> map = {};
    map.addAll({
      'message': EncryptionUtils.encrypt(text: message),
    });

    if (messageToReactTo != null) {
      map.addAll({'messageToReactTo': messageToReactTo});
    }
    if (groupchatTo != null) {
      map.addAll({'groupchatTo': groupchatTo});
    }
    if (privateEventTo != null) {
      map.addAll({'privateEventTo': privateEventTo});
    }
    if (userTo != null) {
      map.addAll({'userTo': userTo});
    }

    return map;
  }
}
