import 'dart:io';

import 'package:chattyevent_app_flutter/core/filter/groupchat/find_one_groupchat_to_filter.dart';

class CreateGroupchatMessageDto extends FindOneGroupchatToFilter {
  final String message;
  final String? messageToReactTo;
  final List<File>? files;

  CreateGroupchatMessageDto({
    required this.message,
    required super.groupchatTo,
    this.files,
    this.messageToReactTo,
  });

  @override
  Map toMap() {
    Map<dynamic, dynamic> map = super.toMap();
    map.addAll({
      'message': message,
      'groupchatTo': groupchatTo,
    });

    if (messageToReactTo != null) {
      map.addAll({'messageToReactTo': messageToReactTo});
    }

    return map;
  }
}
