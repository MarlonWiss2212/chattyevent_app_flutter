import 'package:chattyevent_app_flutter/core/response/event/event_add_user.response.dart';
import 'package:dartz/dartz.dart';
import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:chattyevent_app_flutter/infrastructure/dto/event/create_event_dto.dart';
import 'package:chattyevent_app_flutter/infrastructure/dto/event/event_left_user/create_event_left_user_dto.dart';
import 'package:chattyevent_app_flutter/infrastructure/dto/event/event_user/create_event_user_dto.dart';
import 'package:chattyevent_app_flutter/infrastructure/dto/event/update_event_dto.dart';
import 'package:chattyevent_app_flutter/infrastructure/dto/event/event_user/update_event_user_dto.dart';
import 'package:chattyevent_app_flutter/infrastructure/filter/limit_offset_filter.dart';
import 'package:chattyevent_app_flutter/infrastructure/filter/event/find_one_event_filter.dart';
import 'package:chattyevent_app_flutter/infrastructure/filter/event/find_one_event_to_filter.dart';
import 'package:chattyevent_app_flutter/infrastructure/filter/event/find_events_filter.dart';
import 'package:chattyevent_app_flutter/infrastructure/filter/event/event_user/find_one_event_user_filter.dart';
import 'package:chattyevent_app_flutter/core/response/event/event-date.response.dart';
import 'package:chattyevent_app_flutter/core/response/event/event-users-and-left-users.reponse.dart';
import 'package:chattyevent_app_flutter/domain/entities/event/event_entity.dart';
import 'package:chattyevent_app_flutter/domain/entities/event/event_left_user_entity.dart';
import 'package:chattyevent_app_flutter/domain/entities/event/event_user_entity.dart';

/// Repository for handling event-related functionality.
abstract class EventRepository {
  /// Creates an event via API.
  /// Returns a [NotificationAlert] in case of an error or an [EventEntity] when successful.
  Future<Either<NotificationAlert, EventEntity>> createEventViaApi(
    CreateEventDto createEventDto,
  );

  /// Retrieves an event via API.
  /// Returns a [NotificationAlert] in case of an error or an [EventEntity] when successful.
  Future<Either<NotificationAlert, EventEntity>> getEventViaApi({
    required FindOneEventFilter findOneEventFilter,
  });

  /// Retrieves event data via API.
  /// Returns a [NotificationAlert] in case of an error or an [EventDataResponse] when successful.
  Future<Either<NotificationAlert, EventDataResponse>> getEventDataViaApi({
    required FindOneEventFilter findOneEventFilter,
    String? groupchatId,
  });

  /// Retrieves events via API.
  /// Returns a [NotificationAlert] in case of an error or a list of [EventEntity] when successful.
  Future<Either<NotificationAlert, List<EventEntity>>> getEventsViaApi({
    FindEventsFilter? findEventsFilter,
    required LimitOffsetFilter limitOffsetFilter,
  });

  /// Updates an event via API.
  /// Returns a [NotificationAlert] in case of an error or an [EventEntity] when successful.
  Future<Either<NotificationAlert, EventEntity>> updateEventViaApi({
    required UpdateEventDto updateEventDto,
    required FindOneEventFilter findOneEventFilter,
  });

  /// Deletes an event via API.
  /// Returns a [NotificationAlert] in case of an error or a boolean indicating success.
  Future<Either<NotificationAlert, bool>> deleteEventViaApi({
    required FindOneEventFilter findOneEventFilter,
  });

  /// Retrieves event users and left users.
  /// Returns a [NotificationAlert] in case of an error or an [EventUsersAndLeftUsersResponse] when successful.
  Future<Either<NotificationAlert, EventUsersAndLeftUsersResponse>>
      getEventUsersAndLeftUsers({
    required FindOneEventToFilter findOneEventToFilter,
  });

  /// Adds a user to an event via API.
  /// Returns a [NotificationAlert] in case of an error or an [EventAddUserResponse] when successful.
  Future<Either<NotificationAlert, EventAddUserResponse>> addUserToEventViaApi({
    required CreateEventUserDto createEventUserDto,
  });

  /// Updates an event user.
  /// Returns a [NotificationAlert] in case of an error or an [EventUserEntity] when successful.
  Future<Either<NotificationAlert, EventUserEntity>> updateEventUser({
    required UpdateEventUserDto updateEventUserDto,
    required FindOneEventUserFilter findOneEventUserFilter,
  });

  /// Deletes a user from an event via API.
  /// Returns a [NotificationAlert] in case of an error or an [EventLeftUserEntity] when successful.
  Future<Either<NotificationAlert, EventLeftUserEntity>>
      deleteUserFromEventViaApi({
    required CreateEventLeftUserDto createEventLeftUserDto,
  });
}
