import 'package:chattyevent_app_flutter/infrastructure/dto/user/update_user_permissions/update_calendar_watch_i_have_time_dto.dart';
import 'package:chattyevent_app_flutter/infrastructure/dto/user/update_user_permissions/update_groupchat_add_me_dto.dart';
import 'package:chattyevent_app_flutter/infrastructure/dto/user/update_user_permissions/update_private_event_add_me_dto.dart';

class UpdateUserPermissionsDto {
  final UpdateGroupchatAddMeDto? groupchatAddMe;
  final UpdatePrivateEventAddMeDto? privateEventAddMe;
  final UpdateCalendarWatchIHaveTimeDto? calendarWatchIHaveTime;

  UpdateUserPermissionsDto({
    this.calendarWatchIHaveTime,
    this.groupchatAddMe,
    this.privateEventAddMe,
  });

  Map<dynamic, dynamic> toMap() {
    Map<dynamic, dynamic> variables = {};

    if (groupchatAddMe != null) {
      variables.addAll({"groupchatAddMe": groupchatAddMe!.toMap()});
    }
    if (privateEventAddMe != null) {
      variables.addAll({"privateEventAddMe": privateEventAddMe!.toMap()});
    }
    if (calendarWatchIHaveTime != null) {
      variables.addAll({
        "calendarWatchIHaveTime": calendarWatchIHaveTime!.toMap(),
      });
    }
    return variables;
  }
}
