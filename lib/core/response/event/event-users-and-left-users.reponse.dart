import 'package:chattyevent_app_flutter/domain/entities/event/event_left_user_entity.dart';
import 'package:chattyevent_app_flutter/domain/entities/event/event_user_entity.dart';

class EventUsersAndLeftUsersResponse {
  final List<EventUserEntity> eventUsers;
  final List<EventLeftUserEntity> eventLeftUsers;

  EventUsersAndLeftUsersResponse({
    required this.eventUsers,
    required this.eventLeftUsers,
  });
}
