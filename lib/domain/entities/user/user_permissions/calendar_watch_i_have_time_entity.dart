import 'package:chattyevent_app_flutter/core/enums/user/calendar_watch_i_have_time_permission_enum.dart';

class CalendarWatchIHaveTimeEntity {
  final CalendarWatchIHaveTimePermissionEnum? permission;
  final List<String>? exceptUserIds;
  final List<String>? selectedUserIds;

  CalendarWatchIHaveTimeEntity({
    this.permission,
    this.exceptUserIds,
    this.selectedUserIds,
  });

  /// only use this when changing a value
  factory CalendarWatchIHaveTimeEntity.merge({
    required CalendarWatchIHaveTimeEntity newEntity,
    required CalendarWatchIHaveTimeEntity oldEntity,
  }) {
    return CalendarWatchIHaveTimeEntity(
      permission: newEntity.permission ?? oldEntity.permission,
      exceptUserIds: newEntity.exceptUserIds ?? oldEntity.exceptUserIds,
      selectedUserIds: newEntity.selectedUserIds ?? oldEntity.selectedUserIds,
    );
  }
}
