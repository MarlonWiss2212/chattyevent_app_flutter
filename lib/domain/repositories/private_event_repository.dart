import 'package:dartz/dartz.dart';
import 'package:social_media_app_flutter/core/dto/private_event/create_private_event_dto.dart';
import 'package:social_media_app_flutter/core/dto/private_event/create_private_event_user_dto.dart';
import 'package:social_media_app_flutter/core/dto/private_event/update_private_event_user_dto.dart';
import 'package:social_media_app_flutter/domain/entities/private_event/private_event_entity.dart';
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
  });
  Future<Either<Failure, PrivateEventEntity>> updatePrivateEventViaApi();

  Future<Either<Failure, PrivateEventUserEntity>> createPrivateEventUserViaApi({
    required CreatePrivateEventUserDto createPrivateEventUserDto,
  });

  Future<Either<Failure, PrivateEventUserEntity>> updatePrivateEventUser({
    required UpdatePrivateEventUserDto updatePrivateEventUserDto,
  });

  Future<Either<Failure, void>> deletePrivateEventViaApi();
}
