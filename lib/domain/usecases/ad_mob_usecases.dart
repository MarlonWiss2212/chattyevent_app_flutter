import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:chattyevent_app_flutter/domain/repositories/ad_mob_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_funding_choices/flutter_funding_choices.dart';

class AdMobUseCases {
  final AdMobRepository adMobRepository;
  AdMobUseCases({
    required this.adMobRepository,
  });

  Future<Either<NotificationAlert, Unit>> showAdMobPopUpIfRequired() async {
    final consentInfoOrFailure =
        await adMobRepository.requestConsentInformation();
    return await consentInfoOrFailure.fold(
      (alert) => Left(alert),
      (consentInfo) async {
        if (consentInfo.isConsentFormAvailable &&
            consentInfo.consentStatus == ConsentStatus.required) {
          await adMobRepository.showConsentForm();
          return const Right(unit);
        }
        return const Right(unit);
      },
    );
  }
}
