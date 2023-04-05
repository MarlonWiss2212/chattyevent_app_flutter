import 'package:dartz/dartz.dart';
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
import 'package:social_media_app_flutter/core/failures/failures.dart';
import 'package:social_media_app_flutter/core/filter/get_one_private_event_filter.dart';
import 'package:social_media_app_flutter/core/filter/get_private_events_filter.dart';

abstract class PrivateEventRepository {
  Future<Either<Failure, PrivateEventEntity>> createPrivateEventViaApi(
    CreatePrivateEventDto createPrivateEventDto,
  );
  Future<Either<Failure, PrivateEventEntity>> getPrivateEventViaApi({
    required GetOnePrivateEventFilter getOnePrivateEventFilter,
  });
  Future<Either<Failure, List<PrivateEventEntity>>> getPrivateEventsViaApi({
    GetPrivateEventsFilter? getPrivateEventsFilter,
    required LimitOffsetFilter limitOffsetFilter,
  });
  Future<Either<Failure, PrivateEventEntity>> updatePrivateEventViaApi({
    required UpdatePrivateEventDto updatePrivateEventDto,
    required GetOnePrivateEventFilter getOnePrivateEventFilter,
  });

  Future<Either<Failure, bool>> deletePrivateEventViaApi({
    required GetOnePrivateEventFilter getOnePrivateEventFilter,
  });

  Future<Either<Failure, GetAllPrivateEventUsersAndLeftUsers>>
      getAllPrivateEventUsersAndLeftUsers({
    required String privateEventId,
  });

  Future<Either<Failure, PrivateEventUserEntity>> addUserToPrivateEventViaApi({
    required CreatePrivateEventUserDto createPrivateEventUserDto,
  });

  Future<Either<Failure, PrivateEventUserEntity>> updatePrivateEventUser({
    required UpdatePrivateEventUserDto updatePrivateEventUserDto,
    required GetOnePrivateEventUserFilter getOnePrivateEventUserFilter,
  });

  Future<Either<Failure, PrivateEventLeftUserEntity>>
      deleteUserFromPrivateEventViaApi({
    required GetOnePrivateEventUserFilter getOnePrivateEventUserFilter,
  });
}
