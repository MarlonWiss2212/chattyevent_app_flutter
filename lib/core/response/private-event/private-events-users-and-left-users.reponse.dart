import 'package:chattyevent_app_flutter/domain/entities/private_event/private_event_left_user_entity.dart';
import 'package:chattyevent_app_flutter/domain/entities/private_event/private_event_user_entity.dart';

class PrivateEventUsersAndLeftUsersResponse {
  final List<PrivateEventUserEntity> privateEventUsers;
  final List<PrivateEventLeftUserEntity> privateEventLeftUsers;

  PrivateEventUsersAndLeftUsersResponse({
    required this.privateEventUsers,
    required this.privateEventLeftUsers,
  });
}
