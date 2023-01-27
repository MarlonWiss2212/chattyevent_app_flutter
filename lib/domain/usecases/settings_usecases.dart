import 'package:dartz/dartz.dart';
import 'package:social_media_app_flutter/domain/failures/failures.dart';
import 'package:social_media_app_flutter/domain/repositories/device/settings_repository.dart';

class SettingsUseCases {
  final SettingsRepository settingsRepository;
  SettingsUseCases({required this.settingsRepository});

  Future<void> saveAutoDarkModeInStorage({required bool autoDarkMode}) {
    return settingsRepository.saveAutoDarkModeInStorage(
      autoDarkMode: autoDarkMode,
    );
  }

  Future<Either<Failure, bool>> getAutoDarkModeFromStorage() {
    return settingsRepository.getAutoDarkModeFromStorage();
  }

  Future<void> saveDarkModeInStorage({required bool darkMode}) {
    return settingsRepository.saveDarkModeInStorage(darkMode: darkMode);
  }

  Future<Either<Failure, bool>> getDarkModeFromStorage() {
    return settingsRepository.getDarkModeFromStorage();
  }
}
