import 'package:chattyevent_app_flutter/core/filter/calendar/find_time_by_users_calendar_filter.dart';
import 'package:chattyevent_app_flutter/core/filter/limit_offset_filter.dart';
import 'package:chattyevent_app_flutter/domain/entities/calendar/calendar_time_user_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';

abstract class CalendarRepository {
  Future<Either<NotificationAlert, List<CalendarTimeUserEntity>>>
      getTimeByUsers({
    required FindTimeByUsersCalendarFilter findTimeByUsersCalendarFilter,
    required LimitOffsetFilter groupchatLimitOffsetInput,
  });
}
