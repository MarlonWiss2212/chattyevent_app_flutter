import 'package:chattyevent_app_flutter/domain/entities/message/message_entity.dart';
import 'package:chattyevent_app_flutter/domain/entities/user/user_entity.dart';

class MessageAndUserEntity {
  final UserEntity user;
  final MessageEntity message;
  final String? notificationText;
  MessageAndUserEntity({
    required this.message,
    required this.user,
    this.notificationText,
  });
}
