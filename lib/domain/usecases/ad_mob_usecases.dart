import 'dart:io';

import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:chattyevent_app_flutter/domain/repositories/ad_mob_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_funding_choices/flutter_funding_choices.dart';

class AdMobUseCases {
  final AdMobRepository adMobRepository;
  AdMobUseCases({
    required this.adMobRepository,
  });

  Future<Either<NotificationAlert, Unit>> _requestAdMobInfo() async {
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

  Future<Either<NotificationAlert, Unit>> showAdMobPopUpIfRequired() async {
    if(Platform.isIOS) {
      final iosStatus = await adMobRepository.requestiOSAppTrackingInfo();
      return await iosStatus.fold(
        (alert) => Left(alert), 
        (info) async {
          if(info == TrackingStatus.notDetermined) {
            final newiosStatus = await adMobRepository.showiOSAppTracking();
            return await newiosStatus.fold(
              (alert) => Left(alert), 
              (newInfo) async {
                if(newInfo == TrackingStatus.notDetermined) {
                  return await _requestAdMobInfo();
                }
                return const Right(unit);
              }
            );
          }
          return const Right(unit);
        }
      );
    } else {
      return _requestAdMobInfo();
    }
  }
}
