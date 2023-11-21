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
import 'package:chattyevent_app_flutter/domain/repositories/event_repository.dart';

class EventUseCases {
  final EventRepository privateEventRepository;
  EventUseCases({required this.privateEventRepository});

  Future<Either<NotificationAlert, EventEntity>> createEventViaApi(
      CreateEventDto createEventDto) async {
    return await privateEventRepository.createEventViaApi(
      createEventDto,
    );
  }

  Future<Either<NotificationAlert, EventEntity>> getEventViaApi({
    required FindOneEventFilter findOneEventFilter,
  }) async {
    return await privateEventRepository.getEventViaApi(
      findOneEventFilter: findOneEventFilter,
    );
  }

  Future<Either<NotificationAlert, EventDataResponse>> getEventDataViaApi({
    required FindOneEventFilter findOneEventFilter,
    String? groupchatId,
  }) async {
    return await privateEventRepository.getEventDataViaApi(
      findOneEventFilter: findOneEventFilter,
      groupchatId: groupchatId,
    );
  }

  Future<Either<NotificationAlert, List<EventEntity>>> getEventsViaApi({
    FindEventsFilter? findEventsFilter,
    required LimitOffsetFilter limitOffsetFilter,
  }) async {
    return await privateEventRepository.getEventsViaApi(
      findEventsFilter: findEventsFilter,
      limitOffsetFilter: limitOffsetFilter,
    );
  }

  Future<Either<NotificationAlert, EventEntity>> updatePrivateEvent({
    required UpdateEventDto updateEventDto,
    required FindOneEventFilter findOneEventFilter,
  }) async {
    return await privateEventRepository.updateEventViaApi(
      updateEventDto: updateEventDto,
      findOneEventFilter: findOneEventFilter,
    );
  }

  Future<Either<NotificationAlert, bool>> deleteEventViaApi({
    required FindOneEventFilter findOneEventFilter,
  }) async {
    return await privateEventRepository.deleteEventViaApi(
      findOneEventFilter: findOneEventFilter,
    );
  }

  Future<Either<NotificationAlert, EventUsersAndLeftUsersResponse>>
      getEventUsersAndLeftUsers({
    required FindOneEventToFilter findOneEventToFilter,
  }) async {
    return await privateEventRepository.getEventUsersAndLeftUsers(
      findOneEventToFilter: findOneEventToFilter,
    );
  }

  Future<Either<NotificationAlert, EventAddUserResponse>> addUserToEventViaApi({
    required CreateEventUserDto createEventUserDto,
  }) async {
    return await privateEventRepository.addUserToEventViaApi(
      createEventUserDto: createEventUserDto,
    );
  }

  Future<Either<NotificationAlert, EventLeftUserEntity>>
      deleteUserFromEventViaApi({
    required CreateEventLeftUserDto createEventLeftUserDto,
  }) async {
    return await privateEventRepository.deleteUserFromEventViaApi(
      createEventLeftUserDto: createEventLeftUserDto,
    );
  }

  Future<Either<NotificationAlert, EventUserEntity>> updateEventUser({
    required UpdateEventUserDto updateEventUserDto,
    required FindOneEventUserFilter findOneEventUserFilter,
  }) async {
    return await privateEventRepository.updateEventUser(
      updateEventUserDto: updateEventUserDto,
      findOneEventUserFilter: findOneEventUserFilter,
    );
  }
}
