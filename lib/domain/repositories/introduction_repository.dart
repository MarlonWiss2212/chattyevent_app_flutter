import 'package:chattyevent_app_flutter/domain/entities/introduction/introduction_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';

abstract class IntroductionRepository {
  Future<void> saveIntroductionInStorage({
    required IntroductionEntity introduction,
  });
  Future<Either<NotificationAlert, IntroductionEntity>>
      getIntroductionFromStorage();
}
