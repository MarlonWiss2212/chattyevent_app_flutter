import 'package:chattyevent_app_flutter/domain/entities/introduction/introduction_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';

/// Repository for handling introduction-related functionality.
abstract class IntroductionRepository {
  /// Saves the introduction in storage.
  Future<void> saveIntroductionInStorage({
    required IntroductionEntity introduction,
  });

  /// Retrieves the introduction from storage.
  /// Returns a [NotificationAlert] in case of an error or an [IntroductionEntity] when successful.
  Either<NotificationAlert, IntroductionEntity> getIntroductionFromStorage();
}
