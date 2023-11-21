import 'package:chattyevent_app_flutter/domain/entities/user/user_permissions_entity.dart';
import 'package:chattyevent_app_flutter/infrastructure/models/user/user_permissions/calendar_watch_i_have_time_model.dart';
import 'package:chattyevent_app_flutter/infrastructure/models/user/user_permissions/groupchat_add_me_model.dart';
import 'package:chattyevent_app_flutter/infrastructure/models/user/user_permissions/private_event_add_me_model.dart';

class UserPermissionsModel extends UserPermissionsEntity {
  UserPermissionsModel({
    super.calendarWatchIHaveTime,
    super.groupchatAddMe,
    super.privateEventAddMe,
  });

  factory UserPermissionsModel.fromJson(Map<String, dynamic> json) {
    return UserPermissionsModel(
      calendarWatchIHaveTime: json['calendarWatchIHaveTime'] != null
          ? CalendarWatchIHaveTimeModel.fromJson(
              json['calendarWatchIHaveTime'],
            )
          : null,
      groupchatAddMe: json['groupchatAddMe'] != null
          ? GroupchatAddMeModel.fromJson(
              json['groupchatAddMe'],
            )
          : null,
      privateEventAddMe: json['privateEventAddMe'] != null
          ? PrivateEventAddMeModel.fromJson(
              json['privateEventAddMe'],
            )
          : null,
    );
  }
}
