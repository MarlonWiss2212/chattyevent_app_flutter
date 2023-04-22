import 'package:dartz/dartz.dart';
import 'package:social_media_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:social_media_app_flutter/core/dto/private_event/create_private_event_dto.dart';
import 'package:social_media_app_flutter/core/dto/private_event/private_event_user/create_private_event_user_dto.dart';
import 'package:social_media_app_flutter/core/dto/private_event/update_private_event_dto.dart';
import 'package:social_media_app_flutter/core/dto/private_event/private_event_user/update_private_event_user_dto.dart';
import 'package:social_media_app_flutter/core/filter/limit_offset_filter/limit_offset_filter.dart';
import 'package:social_media_app_flutter/core/filter/private_event/private_event_user/get_one_private_event_user_filter.dart';
import 'package:social_media_app_flutter/core/response/private-event/private-event-date.response.dart';
import 'package:social_media_app_flutter/core/response/private-event/private-events-users-and-left-users.reponse.dart';
import 'package:social_media_app_flutter/domain/entities/private_event/private_event_entity.dart';
import 'package:social_media_app_flutter/domain/entities/private_event/private_event_left_user_entity.dart';
import 'package:social_media_app_flutter/domain/entities/private_event/private_event_user_entity.dart';
import 'package:social_media_app_flutter/core/filter/get_one_private_event_filter.dart';
import 'package:social_media_app_flutter/core/filter/get_private_events_filter.dart';

abstract class PrivateEventRepository {
  Future<Either<NotificationAlert, PrivateEventEntity>>
      createPrivateEventViaApi(
    CreatePrivateEventDto createPrivateEventDto,
  );
  Future<Either<NotificationAlert, PrivateEventEntity>> getPrivateEventViaApi({
    required GetOnePrivateEventFilter getOnePrivateEventFilter,
  });
  Future<Either<NotificationAlert, PrivateEventDataResponse>>
      getPrivateEventDataViaApi({
    required GetOnePrivateEventFilter getOnePrivateEventFilter,
    String? groupchatId,
  });
  Future<Either<NotificationAlert, List<PrivateEventEntity>>>
      getPrivateEventsViaApi({
    GetPrivateEventsFilter? getPrivateEventsFilter,
    required LimitOffsetFilter limitOffsetFilter,
  });
  Future<Either<NotificationAlert, PrivateEventEntity>>
      updatePrivateEventViaApi({
    required UpdatePrivateEventDto updatePrivateEventDto,
    required GetOnePrivateEventFilter getOnePrivateEventFilter,
  });

  Future<Either<NotificationAlert, bool>> deletePrivateEventViaApi({
    required GetOnePrivateEventFilter getOnePrivateEventFilter,
  });

  Future<Either<NotificationAlert, PrivateEventUsersAndLeftUsersResponse>>
      getPrivateEventUsersAndLeftUsers({
    required String privateEventId,
  });

  Future<Either<NotificationAlert, PrivateEventUserEntity>>
      addUserToPrivateEventViaApi({
    required CreatePrivateEventUserDto createPrivateEventUserDto,
  });

  Future<Either<NotificationAlert, PrivateEventUserEntity>>
      updatePrivateEventUser({
    required UpdatePrivateEventUserDto updatePrivateEventUserDto,
    required GetOnePrivateEventUserFilter getOnePrivateEventUserFilter,
  });

  Future<Either<NotificationAlert, PrivateEventLeftUserEntity>>
      deleteUserFromPrivateEventViaApi({
    required GetOnePrivateEventUserFilter getOnePrivateEventUserFilter,
  });
}
