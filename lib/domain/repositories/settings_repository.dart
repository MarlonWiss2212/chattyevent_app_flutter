import 'package:dartz/dartz.dart';
import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';

/// Repository for handling settings-related functionality.
abstract class SettingsRepository {
  /// Saves the [darkMode] preference in storage.
  Future<void> saveDarkModeInStorage({required bool darkMode});

  /// Retrieves the dark mode preference from storage.
  /// Returns a [NotificationAlert] in case of an error or a [bool] indicating the dark mode preference.
  Either<NotificationAlert, bool> getDarkModeFromStorage();

  /// Saves the auto dark mode preference in storage.
  Future<void> saveAutoDarkModeInStorage({required bool autoDarkMode});

  /// Retrieves the auto dark mode preference from storage.
  /// Returns a [NotificationAlert] in case of an error or a [bool] indicating the auto dark mode preference.
  Either<NotificationAlert, bool> getAutoDarkModeFromStorage();
}
