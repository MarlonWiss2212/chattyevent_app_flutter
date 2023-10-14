import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:chattyevent_app_flutter/domain/repositories/device/permission_repository.dart';
import 'package:chattyevent_app_flutter/domain/repositories/one_signal_repository.dart';
import 'package:chattyevent_app_flutter/presentation/router/router.dart';
import 'package:dartz/dartz.dart';
import 'package:permission_handler/permission_handler.dart';

class OneSignalUseCases {
  final OneSignalRepository oneSignalRepository;
  final PermissionRepository permissionRepository;
  OneSignalUseCases({
    required this.oneSignalRepository,
    required this.permissionRepository,
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

  Future<Either<NotificationAlert, Unit>>
      setNotificationOpenedHandlerIfIHavePermission({
    required AppRouter appRouter,
  }) async {
    final permissionStatus =
        await permissionRepository.getNotificationPermissionStatus();
    if (permissionStatus == PermissionStatus.granted) {
      return oneSignalRepository.setNotificationOpenedHandler(
        appRouter: appRouter,
      );
    }
    return Left(
      NotificationAlert(
        title: "Keine Berechtigung",
        message:
            "Du musst erst die Berechtigung geben bevor du auf Notifications drücken kannst",
      ),
    );
  }

  Future<Either<NotificationAlert, Unit>>
      setNotificationReceivedHandlerIfIHavePermission({
    required AppRouter appRouter,
  }) async {
    final permissionStatus =
        await permissionRepository.getNotificationPermissionStatus();
    if (permissionStatus == PermissionStatus.granted) {
      return oneSignalRepository.setNotificationReceivedHandler(
        appRouter: appRouter,
      );
    }
    return Left(
      NotificationAlert(
        title: "Keine Berechtigung",
        message:
            "Du musst erst die Berechtigung geben bevor du auf Notifications drücken kannst",
      ),
    );
  }
}
