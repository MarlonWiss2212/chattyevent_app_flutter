import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:chattyevent_app_flutter/domain/entities/introduction/app_feature_introduction_entity.dart';
import 'package:chattyevent_app_flutter/domain/entities/introduction/app_permission_introduction_entity.dart';
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
      getIntroductionFromStorageIfNullCreateNew() async {
    final response = introductionRepository.getIntroductionFromStorage();
    return response.fold(
      (alert) async {
        await introductionRepository.saveIntroductionInStorage(
          introduction: IntroductionEntity(
            appFeatureIntroduction: AppFeatureIntroductionEntity(
              finishedUsersPage: false,
              finishedMessagesPage: false,
              finishedPrivateEventPage: false,
              finishedGroupchatsPage: false,
            ),
            appPermissionIntroduction: AppPermissionIntroductionEntity(
              finishedMicrophonePage: false,
              finishedNotificationPage: false,
            ),
          ),
        );
        return introductionRepository.getIntroductionFromStorage();
      },
      (r) => Right(r),
    );
  }
}
