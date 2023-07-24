import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:chattyevent_app_flutter/domain/entities/introduction/introduction_entity.dart';
import 'package:chattyevent_app_flutter/domain/repositories/introduction_repository.dart';
import 'package:dartz/dartz.dart';

class IntroductionUseCases {
  final IntroductionRepository introductionRepository;
  IntroductionUseCases({required this.introductionRepository});

  Future<void> saveIntroductionInStorage({
    required IntroductionEntity introduction,
  }) {
    return introductionRepository.saveIntroductionInStorage(
      introduction: introduction,
    );
  }

  Future<Either<NotificationAlert, IntroductionEntity>>
      getIntroductionFromStorage() {
    return introductionRepository.getIntroductionFromStorage();
  }
}
