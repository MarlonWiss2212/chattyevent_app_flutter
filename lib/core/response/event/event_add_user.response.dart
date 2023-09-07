import 'package:chattyevent_app_flutter/domain/entities/event/event_user_entity.dart';
import 'package:chattyevent_app_flutter/domain/entities/request/request_entity.dart';

class EventAddUserResponse {
  final RequestEntity? request;
  final EventUserEntity? eventUser;

  EventAddUserResponse({
    this.eventUser,
    this.request,
  });
}
