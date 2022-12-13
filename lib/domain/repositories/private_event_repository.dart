import 'package:dartz/dartz.dart';
import 'package:social_media_app_flutter/domain/dto/create_private_event_dto.dart';
import 'package:social_media_app_flutter/domain/entities/private_event_entity.dart';
import 'package:social_media_app_flutter/domain/failures/failures.dart';

abstract class PrivateEventRepository {
  Future<Either<Failure, PrivateEventEntity>> createPrivateEventViaApi(
      CreatePrivateEventDto createPrivateEventDto);
  Future<Either<Failure, PrivateEventEntity>> getPrivateEventViaApi();
  Future<Either<Failure, List<PrivateEventEntity>>> getPrivateEventsViaApi();
  Future<Either<Failure, PrivateEventEntity>> updatePrivateEventViaApi();
  Future<Either<Failure, void>> deletePrivateEventViaApi();
}
