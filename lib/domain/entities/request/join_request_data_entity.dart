import 'package:chattyevent_app_flutter/domain/entities/event/event_entity.dart';
import 'package:chattyevent_app_flutter/domain/entities/groupchat/groupchat_entity.dart';

class JoinRequestDataEntity {
  final EventEntity? event;
  final GroupchatEntity? groupchat;

  JoinRequestDataEntity({
    this.groupchat,
    this.event,
  });
}
