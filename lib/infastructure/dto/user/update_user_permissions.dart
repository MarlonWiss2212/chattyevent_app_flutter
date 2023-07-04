import 'package:chattyevent_app_flutter/infastructure/dto/user/update_user_permissions/update_groupchat_add_me_dto.dart';
import 'package:chattyevent_app_flutter/infastructure/dto/user/update_user_permissions/update_private_event_add_me_dto.dart';

class UpdateUserPermissionsDto {
  final UpdateGroupchatAddMeDto? groupchatAddMe;
  final UpdatePrivateEventAddMeDto? privateEventAddMe;
  final bool? calendarWatchIHaveTime;

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
      variables.addAll({"calendarWatchIHaveTime": calendarWatchIHaveTime});
    }
    return variables;
  }
}
