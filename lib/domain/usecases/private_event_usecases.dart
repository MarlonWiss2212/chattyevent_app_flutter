import 'package:dartz/dartz.dart';
import 'package:social_media_app_flutter/domain/dto/create_private_event_dto.dart';
import 'package:social_media_app_flutter/domain/entities/private_event_entity.dart';
import 'package:social_media_app_flutter/domain/failures/failures.dart';
import 'package:social_media_app_flutter/domain/repositories/private_event_repository.dart';

class PrivateEventUseCases {
  final PrivateEventRepository privateEventRepository;
  PrivateEventUseCases({required this.privateEventRepository});

  Future<Either<Failure, PrivateEventEntity>> createPrivateEventViaApi(
      CreatePrivateEventDto createPrivateEventDto) async {
    return await privateEventRepository
        .createPrivateEventViaApi(createPrivateEventDto);
  }

  Future<Either<Failure, List<PrivateEventEntity>>>
      getPrivateEventsViaApi() async {
    return await privateEventRepository.getPrivateEventsViaApi();
  }
}
