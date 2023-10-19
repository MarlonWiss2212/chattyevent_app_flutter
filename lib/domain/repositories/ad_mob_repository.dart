import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_funding_choices/flutter_funding_choices.dart';

abstract class AdMobRepository {
  Future<Either<NotificationAlert, bool>> showConsentForm();
  Future<Either<NotificationAlert, TrackingStatus>> showiOSAppTracking();
  Future<Either<NotificationAlert, TrackingStatus>> requestiOSAppTrackingInfo();
  Future<Either<NotificationAlert, ConsentInformation>>
      requestConsentInformation();
}
