import 'package:chattyevent_app_flutter/domain/repositories/ad_mob_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:chattyevent_app_flutter/domain/repositories/settings_repository.dart';
import 'package:url_launcher/url_launcher_string.dart';

class SettingsUseCases {
  final SettingsRepository settingsRepository;
  final AdMobRepository adMobRepository;
  SettingsUseCases({
    required this.settingsRepository,
    required this.adMobRepository,
  });

  Future<Either<NotificationAlert, Unit>> showAdMobPopUpIfRequired() async {
    return await adMobRepository.showAdMobPopUpIfRequired();
  }

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

  Future<Either<NotificationAlert, Unit>> openTermsOfUsePage() async {
    try {
      final worked = await launchUrlString(
        "https://chattyevent.com/datasecurity/terms-of-use",
      );
      if (worked == false) {
        return Left(
          NotificationAlert(
            message: "Konnte Nutzungsbedingugen nicht öffnen",
            title:
                "Sie können sie unter folgender URL finden: https://chattyevent.com/datasecurity/eu-dataprotection",
          ),
        );
      }
      return const Right(unit);
    } catch (e) {
      return Left(
        NotificationAlert(
          message: "Konnte Nutzungsbedingugen nicht öffnen",
          title:
              "Sie können sie unter folgender URL finden: https://chattyevent.com/datasecurity/eu-dataprotection",
        ),
      );
    }
  }

  Future<Either<NotificationAlert, Unit>> openRightOnDataAccessPage() async {
    try {
      final worked = await launchUrlString(
        "https://chattyevent.com/datasecurity/right-on-data-access",
      );
      if (worked == false) {
        return Left(
          NotificationAlert(
            message: "Konnte Recht auf Auskunft nicht öffnen",
            title:
                "Sie können sie unter folgender URL finden: https://chattyevent.com/datasecurity/eu-dataprotection",
          ),
        );
      }
      return const Right(unit);
    } catch (e) {
      return Left(
        NotificationAlert(
          message: "Konnte Recht auf Auskunft nicht öffnen",
          title:
              "Sie können sie unter folgender URL finden: https://chattyevent.com/datasecurity/eu-dataprotection",
        ),
      );
    }
  }

  Future<Either<NotificationAlert, Unit>> openDatasecurityPage() async {
    try {
      final worked = await launchUrlString(
        "https://chattyevent.com/datasecurity/eu-dataprotection",
      );
      if (worked == false) {
        return Left(
          NotificationAlert(
            message: "Konnte Datenschutzerklärung nicht öffnen",
            title:
                "Sie können sie unter folgender URL finden: https://chattyevent.com/datasecurity/eu-dataprotection",
          ),
        );
      }
      return const Right(unit);
    } catch (e) {
      return Left(
        NotificationAlert(
          message: "Konnte Datenschutzerklärung nicht öffnen",
          title:
              "Sie können sie unter folgender URL finden: https://chattyevent.com/datasecurity/eu-dataprotection",
        ),
      );
    }
  }
}
