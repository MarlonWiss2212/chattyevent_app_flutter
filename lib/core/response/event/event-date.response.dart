import 'package:chattyevent_app_flutter/core/response/event/event-users-and-left-users.reponse.dart';
import 'package:chattyevent_app_flutter/domain/entities/groupchat/groupchat_entity.dart';
import 'package:chattyevent_app_flutter/domain/entities/event/event_entity.dart';

class EventDataResponse extends EventUsersAndLeftUsersResponse {
  final EventEntity event;
  final GroupchatEntity? groupchat;

  EventDataResponse({
    this.groupchat,
    required this.event,
    required super.eventUsers,
    required super.eventLeftUsers,
  });
}
