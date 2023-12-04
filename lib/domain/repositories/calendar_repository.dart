import 'package:chattyevent_app_flutter/infrastructure/filter/calendar/find_time_by_users_calendar_filter.dart';
import 'package:chattyevent_app_flutter/infrastructure/filter/limit_offset_filter.dart';
import 'package:chattyevent_app_flutter/domain/entities/calendar/calendar_time_user_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';

/// Repository for calendar-related functionality.
abstract class CalendarRepository {
  /// Checks calendar time availability for users.
  /// Returns a [NotificationAlert] in case of an error or a list of [CalendarTimeUserEntity] when successful.
  Future<Either<NotificationAlert, List<CalendarTimeUserEntity>>>
      checkTimeByUsers({
    required CheckTimeByUsersCalendarFilter checkTimeByUsersCalendarFilter,
    LimitOffsetFilter? groupchatLimitOffsetInput,
  });
}
