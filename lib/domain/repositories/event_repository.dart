import 'package:chattyevent_app_flutter/core/response/event/event_add_user.response.dart';
import 'package:dartz/dartz.dart';
import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:chattyevent_app_flutter/infastructure/dto/event/create_event_dto.dart';
import 'package:chattyevent_app_flutter/infastructure/dto/event/event_left_user/create_event_left_user_dto.dart';
import 'package:chattyevent_app_flutter/infastructure/dto/event/event_user/create_event_user_dto.dart';
import 'package:chattyevent_app_flutter/infastructure/dto/event/update_event_dto.dart';
import 'package:chattyevent_app_flutter/infastructure/dto/event/event_user/update_event_user_dto.dart';
import 'package:chattyevent_app_flutter/infastructure/filter/limit_offset_filter.dart';
import 'package:chattyevent_app_flutter/infastructure/filter/event/find_one_event_filter.dart';
import 'package:chattyevent_app_flutter/infastructure/filter/event/find_one_event_to_filter.dart';
import 'package:chattyevent_app_flutter/infastructure/filter/event/find_events_filter.dart';
import 'package:chattyevent_app_flutter/infastructure/filter/event/event_user/find_one_event_user_filter.dart';
import 'package:chattyevent_app_flutter/core/response/event/event-date.response.dart';
import 'package:chattyevent_app_flutter/core/response/event/event-users-and-left-users.reponse.dart';
import 'package:chattyevent_app_flutter/domain/entities/event/event_entity.dart';
import 'package:chattyevent_app_flutter/domain/entities/event/event_left_user_entity.dart';
import 'package:chattyevent_app_flutter/domain/entities/event/event_user_entity.dart';

abstract class EventRepository {
  Future<Either<NotificationAlert, EventEntity>> createEventViaApi(
    CreateEventDto createEventDto,
  );
  Future<Either<NotificationAlert, EventEntity>> getEventViaApi({
    required FindOneEventFilter findOneEventFilter,
  });
  Future<Either<NotificationAlert, EventDataResponse>> getEventDataViaApi({
    required FindOneEventFilter findOneEventFilter,
    String? groupchatId,
  });
  Future<Either<NotificationAlert, List<EventEntity>>> getEventsViaApi({
    FindEventsFilter? findEventsFilter,
    required LimitOffsetFilter limitOffsetFilter,
  });
  Future<Either<NotificationAlert, EventEntity>> updateEventViaApi({
    required UpdateEventDto updateEventDto,
    required FindOneEventFilter findOneEventFilter,
  });

  Future<Either<NotificationAlert, bool>> deleteEventViaApi({
    required FindOneEventFilter findOneEventFilter,
  });

  Future<Either<NotificationAlert, EventUsersAndLeftUsersResponse>>
      getEventUsersAndLeftUsers({
    required FindOneEventToFilter findOneEventToFilter,
  });

  Future<Either<NotificationAlert, EventAddUserResponse>> addUserToEventViaApi({
    required CreateEventUserDto createEventUserDto,
  });

  Future<Either<NotificationAlert, EventUserEntity>> updateEventUser({
    required UpdateEventUserDto updateEventUserDto,
    required FindOneEventUserFilter findOneEventUserFilter,
  });

  Future<Either<NotificationAlert, EventLeftUserEntity>>
      deleteUserFromEventViaApi({
    required CreateEventLeftUserDto createEventLeftUserDto,
  });
}
