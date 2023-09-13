import 'dart:io';

import 'package:chattyevent_app_flutter/domain/usecases/launch_url_usecases.dart';
import 'package:dartz/dartz.dart';
import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:chattyevent_app_flutter/domain/repositories/settings_repository.dart';
import 'package:url_launcher/url_launcher_string.dart';

class SettingsUseCases {
  final SettingsRepository settingsRepository;
  final LaunchUrlUseCases launchUrlUseCases;

  SettingsUseCases({
    required this.settingsRepository,
    required this.launchUrlUseCases,
  });

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

  Future<Either<NotificationAlert, Unit>> openFAQPage() async {
    return await launchUrlUseCases.launchUrl(
      url: "https://chattyevent.com/faq",
      launchMode: Platform.isAndroid || Platform.isIOS
          ? LaunchMode.externalApplication
          : LaunchMode.platformDefault,
    );
  }

  Future<Either<NotificationAlert, Unit>> openImprintPage() async {
    return await launchUrlUseCases.launchUrl(
      url: "https://chattyevent.com/datasecurity/imprint",
      launchMode: Platform.isAndroid || Platform.isIOS
          ? LaunchMode.externalApplication
          : LaunchMode.platformDefault,
    );
  }

  Future<Either<NotificationAlert, Unit>> openTermsOfUsePage() async {
    return await launchUrlUseCases.launchUrl(
      url: "https://chattyevent.com/datasecurity/terms-of-use",
      launchMode: Platform.isAndroid || Platform.isIOS
          ? LaunchMode.externalApplication
          : LaunchMode.platformDefault,
    );
  }

  Future<Either<NotificationAlert, Unit>> openRightOnDataAccessPage() async {
    return await launchUrlUseCases.launchUrl(
      url: "https://chattyevent.com/datasecurity/right-on-data-access",
      launchMode: Platform.isAndroid || Platform.isIOS
          ? LaunchMode.externalApplication
          : LaunchMode.platformDefault,
    );
  }

  Future<Either<NotificationAlert, Unit>> openDatasecurityPage() async {
    return await launchUrlUseCases.launchUrl(
      url: "https://chattyevent.com/datasecurity/eu-dataprotection",
      launchMode: Platform.isAndroid || Platform.isIOS
          ? LaunchMode.externalApplication
          : LaunchMode.platformDefault,
    );
  }
}
