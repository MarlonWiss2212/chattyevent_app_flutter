import 'package:dartz/dartz.dart';
import 'package:social_media_app_flutter/domain/dto/private_event/create_private_event_dto.dart';
import 'package:social_media_app_flutter/domain/entities/private_event/private_event_entity.dart';
import 'package:social_media_app_flutter/domain/failures/failures.dart';
import 'package:social_media_app_flutter/domain/filter/get_one_private_event_filter.dart';
import 'package:social_media_app_flutter/domain/filter/get_private_events_filter.dart';

abstract class PrivateEventRepository {
  Future<Either<Failure, PrivateEventEntity>> createPrivateEventViaApi(
      CreatePrivateEventDto createPrivateEventDto);
  Future<Either<Failure, PrivateEventEntity>> getPrivateEventViaApi({
    required GetOnePrivateEventFilter getOnePrivateEventFilter,
  });
  Future<Either<Failure, List<PrivateEventEntity>>> getPrivateEventsViaApi({
    GetPrivateEventsFilter? getPrivateEventsFilter,
  });
  Future<Either<Failure, PrivateEventEntity>> updatePrivateEventViaApi();
  Future<Either<Failure, PrivateEventEntity>>
      updateMeInPrivateEventWillBeThere({
    required String privateEventId,
  });
  Future<Either<Failure, PrivateEventEntity>>
      updateMeInPrivateEventWillNotBeThere({
    required String privateEventId,
  });
  Future<Either<Failure, PrivateEventEntity>>
      updateMeInPrivateEventNoInformationOnWillBeThere({
    required String privateEventId,
  });
  Future<Either<Failure, void>> deletePrivateEventViaApi();
}
