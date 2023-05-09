import 'package:dartz/dartz.dart';
import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';

abstract class SettingsRepository {
  Future<void> saveDarkModeInStorage({required bool darkMode});
  Future<Either<NotificationAlert, bool>> getDarkModeFromStorage();
  Future<void> saveAutoDarkModeInStorage({
    required bool autoDarkMode,
  });
  Future<Either<NotificationAlert, bool>> getAutoDarkModeFromStorage();
  Future<Either<NotificationAlert, Unit>> openDatasecurityPage();
  Future<Either<NotificationAlert, Unit>> openTermsOfUsePage();
}
