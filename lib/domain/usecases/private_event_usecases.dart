import 'package:dartz/dartz.dart';
import 'package:social_media_app_flutter/domain/dto/private_event/create_private_event_dto.dart';
import 'package:social_media_app_flutter/domain/dto/private_event/update_private_event_user_dto.dart';
import 'package:social_media_app_flutter/domain/entities/private_event/private_event_entity.dart';
import 'package:social_media_app_flutter/domain/entities/private_event/private_event_user_entity.dart';
import 'package:social_media_app_flutter/domain/failures/failures.dart';
import 'package:social_media_app_flutter/domain/filter/get_one_private_event_filter.dart';
import 'package:social_media_app_flutter/domain/filter/get_private_events_filter.dart';
import 'package:social_media_app_flutter/domain/repositories/private_event_repository.dart';

class PrivateEventUseCases {
  final PrivateEventRepository privateEventRepository;
  PrivateEventUseCases({required this.privateEventRepository});

  Future<Either<Failure, PrivateEventEntity>> createPrivateEventViaApi(
      CreatePrivateEventDto createPrivateEventDto) async {
    return await privateEventRepository.createPrivateEventViaApi(
      createPrivateEventDto,
    );
  }

  Future<Either<Failure, PrivateEventEntity>> getPrivateEventViaApi({
    required GetOnePrivateEventFilter getOnePrivateEventFilter,
  }) async {
    return await privateEventRepository.getPrivateEventViaApi(
      getOnePrivateEventFilter: getOnePrivateEventFilter,
    );
  }

  Future<Either<Failure, PrivateEventUserEntity>> updatePrivateEventUser({
    required UpdatePrivateEventUserDto updatePrivateEventUserDto,
    required String privateEventId,
  }) async {
    return await privateEventRepository.updatePrivateEventUser(
      updatePrivateEventUserDto: updatePrivateEventUserDto,
      privateEventId: privateEventId,
    );
  }

  Future<Either<Failure, List<PrivateEventEntity>>> getPrivateEventsViaApi({
    GetPrivateEventsFilter? getPrivateEventsFilter,
  }) async {
    return await privateEventRepository.getPrivateEventsViaApi(
      getPrivateEventsFilter: getPrivateEventsFilter,
    );
  }
}
