import 'package:chattyevent_app_flutter/domain/entities/groupchat/groupchat_entity.dart';
import 'package:chattyevent_app_flutter/domain/entities/event/event_entity.dart';
import 'package:chattyevent_app_flutter/domain/entities/user/user_entity.dart';

class ChatEntity {
  final UserEntity? user;
  final EventEntity? event;
  final GroupchatEntity? groupchat;

  ChatEntity({
    this.user,
    this.groupchat,
    this.event,
  });

  factory ChatEntity.merge({
    required ChatEntity newEntity,
    required ChatEntity oldEntity,
  }) {
    return ChatEntity(
      groupchat: newEntity.groupchat ?? oldEntity.groupchat,
      event: newEntity.event ?? oldEntity.event,
      user: newEntity.user ?? oldEntity.user,
    );
  }
}
