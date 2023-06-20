import 'package:chattyevent_app_flutter/domain/entities/groupchat/groupchat_entity.dart';
import 'package:chattyevent_app_flutter/domain/entities/private_event/private_event_entity.dart';
import 'package:chattyevent_app_flutter/domain/entities/user/user_entity.dart';

class ChatEntity {
  final UserEntity? user;
  final PrivateEventEntity? privateEvent;
  final GroupchatEntity? groupchat;

  ChatEntity({
    this.user,
    this.groupchat,
    this.privateEvent,
  });

  factory ChatEntity.merge({
    required ChatEntity newEntity,
    required ChatEntity oldEntity,
  }) {
    return ChatEntity(
      groupchat: newEntity.groupchat ?? oldEntity.groupchat,
      privateEvent: newEntity.privateEvent ?? oldEntity.privateEvent,
      user: newEntity.user ?? oldEntity.user,
    );
  }
}
