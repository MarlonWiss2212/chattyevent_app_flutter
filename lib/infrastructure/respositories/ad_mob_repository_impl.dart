import 'dart:io';

import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:chattyevent_app_flutter/core/utils/failure_helper.dart';
import 'package:chattyevent_app_flutter/domain/repositories/ad_mob_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_funding_choices/flutter_funding_choices.dart';

class AdMobRepositoryImpl implements AdMobRepository {
  @override
  Future<Either<NotificationAlert, bool>> showConsentForm() async {
    try {
      return Right(await FlutterFundingChoices.showConsentForm());
    } catch (e) {
      return Left(FailureHelper.catchFailureToNotificationAlert(exception: e));
    }
  }

  @override
  Future<Either<NotificationAlert, ConsentInformation>>
      requestConsentInformation() async {
    try {
      final consentInformation =
          await FlutterFundingChoices.requestConsentInformation(isAndroid: Platform.isAndroid,);
      return Right(consentInformation);
    } catch (e) {
      return Left(FailureHelper.catchFailureToNotificationAlert(exception: e));
    }
  }
  
  @override
  Future<Either<NotificationAlert, TrackingStatus>> requestiOSAppTrackingInfo() async {
   try {
      return Right(await AppTrackingTransparency.trackingAuthorizationStatus);
    } catch (e) {
      return Left(FailureHelper.catchFailureToNotificationAlert(exception: e));
    }
  }
  
  @override
  Future<Either<NotificationAlert, TrackingStatus>> showiOSAppTracking() async {
    try {
      return Right(await AppTrackingTransparency.requestTrackingAuthorization());
    } catch (e) {
      return Left(FailureHelper.catchFailureToNotificationAlert(exception: e));
    }
  }
}
