import 'package:social_media_app_flutter/core/failures/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:social_media_app_flutter/domain/repositories/device/settings_repository.dart';
import 'package:social_media_app_flutter/infastructure/datasources/local/sharedPreferences.dart';

class SettingsRepositoryImpl extends SettingsRepository {
  final SharedPreferencesDatasource sharedPrefrencesDatasource;
  SettingsRepositoryImpl({required this.sharedPrefrencesDatasource});

  @override
  Future<void> saveAutoDarkModeInStorage({required bool autoDarkMode}) async {
    return await sharedPrefrencesDatasource.saveBoolToStorage(
      "autoDarkMode",
      autoDarkMode,
    );
  }

  @override
  Future<Either<Failure, bool>> getAutoDarkModeFromStorage() async {
    return await sharedPrefrencesDatasource.getBoolFromStorage("autoDarkMode");
  }

  @override
  Future<void> saveDarkModeInStorage({required bool darkMode}) async {
    return await sharedPrefrencesDatasource.saveBoolToStorage(
      "darkMode",
      darkMode,
    );
  }

  @override
  Future<Either<Failure, bool>> getDarkModeFromStorage() async {
    return await sharedPrefrencesDatasource.getBoolFromStorage("darkMode");
  }
}
