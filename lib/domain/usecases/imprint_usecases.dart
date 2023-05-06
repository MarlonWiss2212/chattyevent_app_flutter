import 'package:chattyevent_app_flutter/domain/entities/imprint/imprint_entity.dart';
import 'package:chattyevent_app_flutter/domain/repositories/imprint_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';

class ImprintUseCases {
  final ImprintRepository imprintRepository;
  ImprintUseCases({required this.imprintRepository});

  Future<Either<NotificationAlert, ImprintEntity>> getImprintViaApi() async {
    return await imprintRepository.getImprintViaApi();
  }
}
