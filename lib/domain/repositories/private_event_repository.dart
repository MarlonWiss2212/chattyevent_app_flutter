import 'package:dartz/dartz.dart';
import 'package:social_media_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:social_media_app_flutter/core/dto/private_event/create_private_event_dto.dart';
import 'package:social_media_app_flutter/core/dto/private_event/private_event_left_user/create_private_event_left_user_dto.dart';
import 'package:social_media_app_flutter/core/dto/private_event/private_event_user/create_private_event_user_dto.dart';
import 'package:social_media_app_flutter/core/dto/private_event/update_private_event_dto.dart';
import 'package:social_media_app_flutter/core/dto/private_event/private_event_user/update_private_event_user_dto.dart';
import 'package:social_media_app_flutter/core/filter/limit_offset_filter.dart';
import 'package:social_media_app_flutter/core/filter/private_event/find_one_private_event_filter.dart';
import 'package:social_media_app_flutter/core/filter/private_event/find_one_private_event_to_filter.dart';
import 'package:social_media_app_flutter/core/filter/private_event/find_private_events_filter.dart';
import 'package:social_media_app_flutter/core/filter/private_event/private_event_user/find_one_private_event_user_filter.dart';
import 'package:social_media_app_flutter/core/response/private-event/private-event-date.response.dart';
import 'package:social_media_app_flutter/core/response/private-event/private-events-users-and-left-users.reponse.dart';
import 'package:social_media_app_flutter/domain/entities/private_event/private_event_entity.dart';
import 'package:social_media_app_flutter/domain/entities/private_event/private_event_left_user_entity.dart';
import 'package:social_media_app_flutter/domain/entities/private_event/private_event_user_entity.dart';

abstract class PrivateEventRepository {
  Future<Either<NotificationAlert, PrivateEventEntity>>
      createPrivateEventViaApi(
    CreatePrivateEventDto createPrivateEventDto,
  );
  Future<Either<NotificationAlert, PrivateEventEntity>> getPrivateEventViaApi({
    required FindOnePrivateEventFilter findOnePrivateEventFilter,
  });
  Future<Either<NotificationAlert, PrivateEventDataResponse>>
      getPrivateEventDataViaApi({
    required FindOnePrivateEventFilter findOnePrivateEventFilter,
    String? groupchatId,
  });
  Future<Either<NotificationAlert, List<PrivateEventEntity>>>
      getPrivateEventsViaApi({
    FindPrivateEventsFilter? findPrivateEventsFilter,
    required LimitOffsetFilter limitOffsetFilter,
  });
  Future<Either<NotificationAlert, PrivateEventEntity>>
      updatePrivateEventViaApi({
    required UpdatePrivateEventDto updatePrivateEventDto,
    required FindOnePrivateEventFilter findOnePrivateEventFilter,
  });

  Future<Either<NotificationAlert, bool>> deletePrivateEventViaApi({
    required FindOnePrivateEventFilter findOnePrivateEventFilter,
  });

  Future<Either<NotificationAlert, PrivateEventUsersAndLeftUsersResponse>>
      getPrivateEventUsersAndLeftUsers({
    required FindOnePrivateEventToFilter findOnePrivateEventToFilter,
  });

  Future<Either<NotificationAlert, PrivateEventUserEntity>>
      addUserToPrivateEventViaApi({
    required CreatePrivateEventUserDto createPrivateEventUserDto,
  });

  Future<Either<NotificationAlert, PrivateEventUserEntity>>
      updatePrivateEventUser({
    required UpdatePrivateEventUserDto updatePrivateEventUserDto,
    required FindOnePrivateEventUserFilter findOnePrivateEventUserFilter,
  });

  Future<Either<NotificationAlert, PrivateEventLeftUserEntity>>
      deleteUserFromPrivateEventViaApi({
    required CreatePrivateEventLeftUserDto createPrivateEventLeftUserDto,
  });
}
