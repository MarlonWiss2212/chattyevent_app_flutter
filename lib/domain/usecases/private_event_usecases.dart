import 'package:dartz/dartz.dart';
import 'package:social_media_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:social_media_app_flutter/core/dto/private_event/create_private_event_dto.dart';
import 'package:social_media_app_flutter/core/dto/private_event/private_event_user/create_private_event_user_dto.dart';
import 'package:social_media_app_flutter/core/dto/private_event/update_private_event_dto.dart';
import 'package:social_media_app_flutter/core/dto/private_event/private_event_user/update_private_event_user_dto.dart';
import 'package:social_media_app_flutter/core/filter/limit_offset_filter/limit_offset_filter.dart';
import 'package:social_media_app_flutter/core/filter/private_event/private_event_user/get_one_private_event_user_filter.dart';
import 'package:social_media_app_flutter/core/response/get-all-private-events-users-and-left-users.reponse.dart';
import 'package:social_media_app_flutter/domain/entities/private_event/private_event_entity.dart';
import 'package:social_media_app_flutter/domain/entities/private_event/private_event_left_user_entity.dart';
import 'package:social_media_app_flutter/domain/entities/private_event/private_event_user_entity.dart';
import 'package:social_media_app_flutter/core/filter/get_one_private_event_filter.dart';
import 'package:social_media_app_flutter/core/filter/get_private_events_filter.dart';
import 'package:social_media_app_flutter/domain/repositories/private_event_repository.dart';

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
    required GetOnePrivateEventFilter getOnePrivateEventFilter,
  }) async {
    return await privateEventRepository.getPrivateEventViaApi(
      getOnePrivateEventFilter: getOnePrivateEventFilter,
    );
  }

  Future<Either<NotificationAlert, List<PrivateEventEntity>>>
      getPrivateEventsViaApi({
    GetPrivateEventsFilter? getPrivateEventsFilter,
    required LimitOffsetFilter limitOffsetFilter,
  }) async {
    return await privateEventRepository.getPrivateEventsViaApi(
      getPrivateEventsFilter: getPrivateEventsFilter,
      limitOffsetFilter: limitOffsetFilter,
    );
  }

  Future<Either<NotificationAlert, PrivateEventEntity>> updatePrivateEvent({
    required UpdatePrivateEventDto updatePrivateEventDto,
    required GetOnePrivateEventFilter getOnePrivateEventFilter,
  }) async {
    return await privateEventRepository.updatePrivateEventViaApi(
      updatePrivateEventDto: updatePrivateEventDto,
      getOnePrivateEventFilter: getOnePrivateEventFilter,
    );
  }

  Future<Either<NotificationAlert, bool>> deletePrivateEventViaApi({
    required GetOnePrivateEventFilter getOnePrivateEventFilter,
  }) async {
    return await privateEventRepository.deletePrivateEventViaApi(
      getOnePrivateEventFilter: getOnePrivateEventFilter,
    );
  }

  // private event users
  Future<Either<NotificationAlert, GetAllPrivateEventUsersAndLeftUsers>>
      getPrivateEventUsersAndLeftUsers({
    required String privateEventId,
  }) async {
    return await privateEventRepository.getAllPrivateEventUsersAndLeftUsers(
      privateEventId: privateEventId,
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
    required GetOnePrivateEventUserFilter getOnePrivateEventUserFilter,
  }) async {
    return await privateEventRepository.deleteUserFromPrivateEventViaApi(
      getOnePrivateEventUserFilter: getOnePrivateEventUserFilter,
    );
  }

  Future<Either<NotificationAlert, PrivateEventUserEntity>>
      updatePrivateEventUser({
    required UpdatePrivateEventUserDto updatePrivateEventUserDto,
    required GetOnePrivateEventUserFilter getOnePrivateEventFilter,
  }) async {
    return await privateEventRepository.updatePrivateEventUser(
      updatePrivateEventUserDto: updatePrivateEventUserDto,
      getOnePrivateEventUserFilter: getOnePrivateEventFilter,
    );
  }
}
