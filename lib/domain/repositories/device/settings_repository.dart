import 'package:dartz/dartz.dart';
import 'package:social_media_app_flutter/application/bloc/notification/notification_cubit.dart';

abstract class SettingsRepository {
  Future<void> saveDarkModeInStorage({required bool darkMode});
  Future<Either<NotificationAlert, bool>> getDarkModeFromStorage();
  Future<void> saveAutoDarkModeInStorage({
    required bool autoDarkMode,
  });
  Future<Either<NotificationAlert, bool>> getAutoDarkModeFromStorage();
}
