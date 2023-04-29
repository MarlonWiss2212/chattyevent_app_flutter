import 'dart:io';

class CreateGroupchatMessageDto {
  String message;
  String groupchatTo;
  String? messageToReactTo;
  File? file;

  CreateGroupchatMessageDto({
    required this.message,
    required this.groupchatTo,
    this.file,
    this.messageToReactTo,
  });

  Map<dynamic, dynamic> toMap() {
    Map<dynamic, dynamic> map = {
      'message': message,
      'groupchatTo': groupchatTo,
    };

    if (messageToReactTo != null) {
      map.addAll({'messageToReactTo': messageToReactTo});
    }

    return map;
  }
}
