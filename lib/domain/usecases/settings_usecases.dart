import 'package:dartz/dartz.dart';
import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:chattyevent_app_flutter/domain/repositories/device/settings_repository.dart';

class SettingsUseCases {
  final SettingsRepository settingsRepository;
  SettingsUseCases({required this.settingsRepository});

  Future<void> saveAutoDarkModeInStorage({required bool autoDarkMode}) {
    return settingsRepository.saveAutoDarkModeInStorage(
      autoDarkMode: autoDarkMode,
    );
  }

  Future<Either<NotificationAlert, bool>> getAutoDarkModeFromStorage() {
    return settingsRepository.getAutoDarkModeFromStorage();
  }

  Future<void> saveDarkModeInStorage({required bool darkMode}) {
    return settingsRepository.saveDarkModeInStorage(darkMode: darkMode);
  }

  Future<Either<NotificationAlert, bool>> getDarkModeFromStorage() {
    return settingsRepository.getDarkModeFromStorage();
  }
}
