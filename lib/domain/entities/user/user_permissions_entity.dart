import 'package:chattyevent_app_flutter/domain/entities/user/user_permissions/calendar_watch_i_have_time_entity.dart';
import 'package:chattyevent_app_flutter/domain/entities/user/user_permissions/groupchat_add_me_entity.dart';
import 'package:chattyevent_app_flutter/domain/entities/user/user_permissions/private_event_add_me_entity.dart';

class UserPermissionsEntity {
  final GroupchatAddMeEntity? groupchatAddMe;
  final PrivateEventAddMeEntity? privateEventAddMe;
  final CalendarWatchIHaveTimeEntity? calendarWatchIHaveTime;

  UserPermissionsEntity({
    this.calendarWatchIHaveTime,
    this.groupchatAddMe,
    this.privateEventAddMe,
  });

  /// only use this when changing a value
  factory UserPermissionsEntity.merge({
    required UserPermissionsEntity newEntity,
    required UserPermissionsEntity oldEntity,
  }) {
    return UserPermissionsEntity(
      calendarWatchIHaveTime:
          newEntity.calendarWatchIHaveTime ?? oldEntity.calendarWatchIHaveTime,
      groupchatAddMe: newEntity.groupchatAddMe ?? oldEntity.groupchatAddMe,
      privateEventAddMe:
          newEntity.privateEventAddMe ?? oldEntity.privateEventAddMe,
    );
  }
}
