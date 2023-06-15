import 'dart:io';

import 'package:chattyevent_app_flutter/core/filter/groupchat/find_one_groupchat_to_filter.dart';
import 'package:chattyevent_app_flutter/core/utils/encryption_utils.dart';

class CreateMessageDto extends FindOneGroupchatToFilter {
  final String message;
  final String? messageToReactTo;
  // TODO: multiple files
  final File? file;

  CreateMessageDto({
    required this.message,
    required super.groupchatTo,
    this.file,
    this.messageToReactTo,
  });

  @override
  Map toMap() {
    Map<dynamic, dynamic> map = super.toMap();
    map.addAll({
      'message': EncryptionUtils.encrypt(text: message),
      'groupchatTo': groupchatTo,
    });

    if (messageToReactTo != null) {
      map.addAll({'messageToReactTo': messageToReactTo});
    }

    return map;
  }
}
