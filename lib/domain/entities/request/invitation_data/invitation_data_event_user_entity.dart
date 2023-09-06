import 'package:chattyevent_app_flutter/core/enums/event/event_user/event_user_role_enum.dart';
import 'package:chattyevent_app_flutter/domain/entities/event/event_entity.dart';

class InvitationDataEventUserEntity {
  final EventUserRoleEnum role;
  final EventEntity event;

  InvitationDataEventUserEntity({
    required this.event,
    required this.role,
  });
}
