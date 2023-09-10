import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:chattyevent_app_flutter/domain/repositories/one_signal_repository.dart';
import 'package:chattyevent_app_flutter/presentation/router/router.dart';
import 'package:dartz/dartz.dart';

class OneSignalUseCases {
  final OneSignalRepository oneSignalRepository;
  OneSignalUseCases({
    required this.oneSignalRepository,
  });

  Future<Either<NotificationAlert, Unit>> setLanguageCode({
    required String languageCode,
  }) {
    return oneSignalRepository.setLanguageCode(languageCode: languageCode);
  }

  Future<Either<NotificationAlert, Unit>> login({required String userId}) {
    return oneSignalRepository.login(userId: userId);
  }

  Future<Either<NotificationAlert, Unit>> logout() {
    return oneSignalRepository.logout();
  }

  Either<NotificationAlert, Unit> setNotificationOpenedHandler({
    required AppRouter appRouter,
  }) {
    return oneSignalRepository.setNotificationOpenedHandler(
      appRouter: appRouter,
    );
  }

  Either<NotificationAlert, Unit> setNotificationReceivedHandler({
    required AppRouter appRouter,
  }) {
    return oneSignalRepository.setNotificationReceivedHandler(
      appRouter: appRouter,
    );
  }
}
