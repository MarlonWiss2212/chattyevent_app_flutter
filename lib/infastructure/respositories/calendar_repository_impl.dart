import 'package:chattyevent_app_flutter/core/filter/calendar/find_time_by_users_calendar_filter.dart';
import 'package:chattyevent_app_flutter/core/filter/limit_offset_filter.dart';
import 'package:chattyevent_app_flutter/core/utils/failure_helper.dart';
import 'package:chattyevent_app_flutter/domain/entities/calendar/calendar_time_user_entity.dart';
import 'package:chattyevent_app_flutter/domain/repositories/calendar_repository.dart';
import 'package:chattyevent_app_flutter/infastructure/datasources/remote/graphql.dart';
import 'package:chattyevent_app_flutter/infastructure/models/calendar/calendar_time_user_model.dart';
import 'package:dartz/dartz.dart';
import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';

class CalendarRepositoryImpl extends CalendarRepository {
  final GraphQlDatasource graphQlDatasource;
  CalendarRepositoryImpl({required this.graphQlDatasource});

  @override
  Future<Either<NotificationAlert, List<CalendarTimeUserEntity>>>
      checkTimeByUsers({
    required CheckTimeByUsersCalendarFilter checkTimeByUsersCalendarFilter,
    LimitOffsetFilter? groupchatLimitOffsetInput,
  }) async {
    try {
      final variables = {"filter": checkTimeByUsersCalendarFilter.toMap()};
      // if (groupchatLimitOffsetInput != null) {
      //   variables.addAll({
      //     "groupchatLimitOffsetInput": groupchatLimitOffsetInput.toMap(),
      //   });
      // }
      //, \$groupchatLimitOffsetInput: LimitOffsetInput
      //, groupchatLimitOffsetInput: \$groupchatLimitOffsetInput
      final response = await graphQlDatasource.query(
        """
        query CheckTimeByUsers(\$filter: CheckTimeByUsersCalendarInput!) {
          checkTimeByUsers(filter: \$filter) {
            username
            _id
            authId
            profileImageLink
            status
            createdAt
            updatedAt
          }
        }
      """,
        variables: variables,
      );

      if (response.hasException) {
        return Left(FailureHelper.graphqlFailureToNotificationAlert(
          title: "Calendar holen Fehler",
          response: response,
        ));
      }

      final List<CalendarTimeUserEntity> calendarTimeUsers = [];
      for (var calendarTimeUser in response.data!["checkTimeByUsers"]) {
        calendarTimeUsers.add(CalendarTimeUserModel.fromJson(calendarTimeUser));
      }
      return Right(calendarTimeUsers);
    } catch (e) {
      return Left(FailureHelper.catchFailureToNotificationAlert(exception: e));
    }
  }
}
