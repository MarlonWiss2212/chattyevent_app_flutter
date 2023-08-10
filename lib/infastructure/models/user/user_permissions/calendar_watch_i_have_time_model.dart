import 'package:chattyevent_app_flutter/core/enums/user/calendar_watch_i_have_time_permission_enum.dart';
import 'package:chattyevent_app_flutter/domain/entities/user/user_permissions/calendar_watch_i_have_time_entity.dart';

class CalendarWatchIHaveTimeModel extends CalendarWatchIHaveTimeEntity {
  CalendarWatchIHaveTimeModel({
    super.permission,
    super.exceptUserIds,
    super.selectedUserIds,
  });

  factory CalendarWatchIHaveTimeModel.fromJson(Map<String, dynamic> json) {
    List<String>? exceptUserIds;
    if (json['exceptUserIds'] != null) {
      exceptUserIds ??= [];
      for (final exceptUserId in json['exceptUserIds']) {
        exceptUserIds.add(exceptUserId);
      }
    }

    List<String>? selectedUserIds;
    if (json['selectedUserIds'] != null) {
      selectedUserIds ??= [];
      for (final selectedUserId in json['selectedUserIds']) {
        selectedUserIds.add(selectedUserId);
      }
    }

    return CalendarWatchIHaveTimeModel(
      permission: json["permission"] != null
          ? CalendarWatchIHaveTimePermissionEnumExtension.fromValue(
              json["permission"])
          : null,
      exceptUserIds: exceptUserIds,
      selectedUserIds: selectedUserIds,
    );
  }
}
