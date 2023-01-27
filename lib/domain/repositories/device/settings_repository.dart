import 'package:dartz/dartz.dart';
import 'package:social_media_app_flutter/domain/failures/failures.dart';

abstract class SettingsRepository {
  Future<void> saveDarkModeInStorage({required bool darkMode});
  Future<Either<Failure, bool>> getDarkModeFromStorage();
  Future<void> saveAutoDarkModeInStorage({
    required bool autoDarkMode,
  });
  Future<Either<Failure, bool>> getAutoDarkModeFromStorage();
}
