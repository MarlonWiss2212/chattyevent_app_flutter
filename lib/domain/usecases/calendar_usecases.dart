import 'package:chattyevent_app_flutter/infrastructure/filter/calendar/find_time_by_users_calendar_filter.dart';
import 'package:chattyevent_app_flutter/domain/entities/calendar/calendar_time_user_entity.dart';
import 'package:chattyevent_app_flutter/domain/repositories/calendar_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:chattyevent_app_flutter/infrastructure/filter/limit_offset_filter.dart';

class CalendarUseCases {
  final CalendarRepository calendarRepository;
  CalendarUseCases({required this.calendarRepository});

  Future<Either<NotificationAlert, List<CalendarTimeUserEntity>>>
      checkTimeByUsers({
    required CheckTimeByUsersCalendarFilter checkTimeByUsersCalendarFilter,
    LimitOffsetFilter? groupchatLimitOffsetInput,
  }) async {
    return await calendarRepository.checkTimeByUsers(
      checkTimeByUsersCalendarFilter: checkTimeByUsersCalendarFilter,
      groupchatLimitOffsetInput: groupchatLimitOffsetInput,
    );
  }
}
