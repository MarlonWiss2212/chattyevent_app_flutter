import 'package:chattyevent_app_flutter/core/response/private-event/private-events-users-and-left-users.reponse.dart';
import 'package:chattyevent_app_flutter/domain/entities/groupchat/groupchat_entity.dart';
import 'package:chattyevent_app_flutter/domain/entities/private_event/private_event_entity.dart';

class PrivateEventDataResponse extends PrivateEventUsersAndLeftUsersResponse {
  final PrivateEventEntity privateEvent;
  final GroupchatEntity? groupchat;

  PrivateEventDataResponse({
    this.groupchat,
    required this.privateEvent,
    required super.privateEventUsers,
    required super.privateEventLeftUsers,
  });
}
