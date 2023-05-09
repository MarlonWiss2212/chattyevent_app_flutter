import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:chattyevent_app_flutter/infastructure/datasources/local/weblink.dart';
import 'package:dartz/dartz.dart';
import 'package:chattyevent_app_flutter/domain/repositories/settings_repository.dart';
import 'package:chattyevent_app_flutter/infastructure/datasources/local/sharedPreferences.dart';

class SettingsRepositoryImpl extends SettingsRepository {
  final SharedPreferencesDatasource sharedPrefrencesDatasource;
  final WeblinkDatasource weblinkDatasource;
  SettingsRepositoryImpl({
    required this.sharedPrefrencesDatasource,
    required this.weblinkDatasource,
  });

  @override
  Future<void> saveAutoDarkModeInStorage({required bool autoDarkMode}) async {
    return await sharedPrefrencesDatasource.saveBoolToStorage(
      "autoDarkMode",
      autoDarkMode,
    );
  }

  @override
  Future<Either<NotificationAlert, bool>> getAutoDarkModeFromStorage() async {
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
  Future<Either<NotificationAlert, bool>> getDarkModeFromStorage() async {
    return await sharedPrefrencesDatasource.getBoolFromStorage("darkMode");
  }

  @override
  Future<Either<NotificationAlert, Unit>> openDatasecurityPage() async {
    try {
      final worked = await weblinkDatasource.launchUrl(
        url: "https://chattyevent-info-web.pages.dev/eu-dataprotection",
      );
      if (worked == false) {
        return Left(
          NotificationAlert(
            message: "Konnte Datenschutzerklärung nicht öffnen",
            title:
                "Sie können sie unter folgender URL finden: https://chattyevent-info-web.pages.dev/eu-dataprotection",
          ),
        );
      }
      return const Right(unit);
    } catch (e) {
      return Left(
        NotificationAlert(
          message: "Konnte Datenschutzerklärung nicht öffnen",
          title:
              "Sie können sie unter folgender URL finden: https://chattyevent-info-web.pages.dev/eu-dataprotection",
        ),
      );
    }
  }

  @override
  Future<Either<NotificationAlert, Unit>> openTermsOfUsePage() async {
    try {
      final worked = await weblinkDatasource.launchUrl(
        url: "https://chattyevent-info-web.pages.dev/terms-of-use",
      );
      if (worked == false) {
        return Left(
          NotificationAlert(
            message: "Konnte Nutzungsbedingugen nicht öffnen",
            title:
                "Sie können sie unter folgender URL finden: https://chattyevent-info-web.pages.dev/eu-dataprotection",
          ),
        );
      }
      return const Right(unit);
    } catch (e) {
      return Left(
        NotificationAlert(
          message: "Konnte Nutzungsbedingugen nicht öffnen",
          title:
              "Sie können sie unter folgender URL finden: https://chattyevent-info-web.pages.dev/eu-dataprotection",
        ),
      );
    }
  }
}
