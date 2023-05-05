import 'package:dartz/dartz.dart';
import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:chattyevent_app_flutter/core/dto/private_event/create_private_event_dto.dart';
import 'package:chattyevent_app_flutter/core/dto/private_event/private_event_left_user/create_private_event_left_user_dto.dart';
import 'package:chattyevent_app_flutter/core/dto/private_event/private_event_user/create_private_event_user_dto.dart';
import 'package:chattyevent_app_flutter/core/dto/private_event/update_private_event_dto.dart';
import 'package:chattyevent_app_flutter/core/dto/private_event/private_event_user/update_private_event_user_dto.dart';
import 'package:chattyevent_app_flutter/core/filter/limit_offset_filter.dart';
import 'package:chattyevent_app_flutter/core/filter/private_event/find_one_private_event_filter.dart';
import 'package:chattyevent_app_flutter/core/filter/private_event/find_one_private_event_to_filter.dart';
import 'package:chattyevent_app_flutter/core/filter/private_event/find_private_events_filter.dart';
import 'package:chattyevent_app_flutter/core/filter/private_event/private_event_user/find_one_private_event_user_filter.dart';
import 'package:chattyevent_app_flutter/core/response/private-event/private-event-date.response.dart';
import 'package:chattyevent_app_flutter/core/response/private-event/private-events-users-and-left-users.reponse.dart';
import 'package:chattyevent_app_flutter/domain/entities/private_event/private_event_entity.dart';
import 'package:chattyevent_app_flutter/domain/entities/private_event/private_event_left_user_entity.dart';
import 'package:chattyevent_app_flutter/domain/entities/private_event/private_event_user_entity.dart';
import 'package:chattyevent_app_flutter/domain/repositories/private_event_repository.dart';

class PrivateEventUseCases {
  final PrivateEventRepository privateEventRepository;
  PrivateEventUseCases({required this.privateEventRepository});

  Future<Either<NotificationAlert, PrivateEventEntity>>
      createPrivateEventViaApi(
          CreatePrivateEventDto createPrivateEventDto) async {
    return await privateEventRepository.createPrivateEventViaApi(
      createPrivateEventDto,
    );
  }

  Future<Either<NotificationAlert, PrivateEventEntity>> getPrivateEventViaApi({
    required FindOnePrivateEventFilter findOnePrivateEventFilter,
  }) async {
    return await privateEventRepository.getPrivateEventViaApi(
      findOnePrivateEventFilter: findOnePrivateEventFilter,
    );
  }

  Future<Either<NotificationAlert, PrivateEventDataResponse>>
      getPrivateEventDataViaApi({
    required FindOnePrivateEventFilter findOnePrivateEventFilter,
    String? groupchatId,
  }) async {
    return await privateEventRepository.getPrivateEventDataViaApi(
      findOnePrivateEventFilter: findOnePrivateEventFilter,
      groupchatId: groupchatId,
    );
  }

  Future<Either<NotificationAlert, List<PrivateEventEntity>>>
      getPrivateEventsViaApi({
    FindPrivateEventsFilter? findPrivateEventsFilter,
    required LimitOffsetFilter limitOffsetFilter,
  }) async {
    return await privateEventRepository.getPrivateEventsViaApi(
      findPrivateEventsFilter: findPrivateEventsFilter,
      limitOffsetFilter: limitOffsetFilter,
    );
  }

  Future<Either<NotificationAlert, PrivateEventEntity>> updatePrivateEvent({
    required UpdatePrivateEventDto updatePrivateEventDto,
    required FindOnePrivateEventFilter findOnePrivateEventFilter,
  }) async {
    return await privateEventRepository.updatePrivateEventViaApi(
      updatePrivateEventDto: updatePrivateEventDto,
      findOnePrivateEventFilter: findOnePrivateEventFilter,
    );
  }

  Future<Either<NotificationAlert, bool>> deletePrivateEventViaApi({
    required FindOnePrivateEventFilter findOnePrivateEventFilter,
  }) async {
    return await privateEventRepository.deletePrivateEventViaApi(
      findOnePrivateEventFilter: findOnePrivateEventFilter,
    );
  }

  // private event users
  Future<Either<NotificationAlert, PrivateEventUsersAndLeftUsersResponse>>
      getPrivateEventUsersAndLeftUsers({
    required FindOnePrivateEventToFilter findOnePrivateEventToFilter,
  }) async {
    return await privateEventRepository.getPrivateEventUsersAndLeftUsers(
      findOnePrivateEventToFilter: findOnePrivateEventToFilter,
    );
  }

  Future<Either<NotificationAlert, PrivateEventUserEntity>>
      addUserToPrivateEventViaApi({
    required CreatePrivateEventUserDto createPrivateEventUserDto,
  }) async {
    return await privateEventRepository.addUserToPrivateEventViaApi(
      createPrivateEventUserDto: createPrivateEventUserDto,
    );
  }

  Future<Either<NotificationAlert, PrivateEventLeftUserEntity>>
      deleteUserFromPrivateEventViaApi({
    required CreatePrivateEventLeftUserDto createPrivateEventLeftUserDto,
  }) async {
    return await privateEventRepository.deleteUserFromPrivateEventViaApi(
      createPrivateEventLeftUserDto: createPrivateEventLeftUserDto,
    );
  }

  Future<Either<NotificationAlert, PrivateEventUserEntity>>
      updatePrivateEventUser({
    required UpdatePrivateEventUserDto updatePrivateEventUserDto,
    required FindOnePrivateEventUserFilter findOnePrivateEventUserFilter,
  }) async {
    return await privateEventRepository.updatePrivateEventUser(
      updatePrivateEventUserDto: updatePrivateEventUserDto,
      findOnePrivateEventUserFilter: findOnePrivateEventUserFilter,
    );
  }
}
