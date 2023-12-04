import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_funding_choices/flutter_funding_choices.dart';

abstract class AdMobRepository {
  /// Opens the Consent Form and <br /><br />
  /// either return a [NotificationAlert] when an error occurred or
  /// returns weather it opened
  Future<Either<NotificationAlert, bool>> showConsentForm();

  /// Shows iOS App Tracking API and <br /><br />
  /// either return a [NotificationAlert] when an error occurred or
  /// returns the [TrackingStatus]
  Future<Either<NotificationAlert, TrackingStatus>> showiOSAppTracking();

  /// Requests iOS App Tracking API and <br /><br />
  /// either return a [NotificationAlert] when an error occurred or
  /// returns the [NotificationAlert]
  Future<Either<NotificationAlert, TrackingStatus>> requestiOSAppTrackingInfo();

  /// Requests Consent Information <br /><br />
  /// either return a [NotificationAlert] when an error occurred or
  /// returns the [ConsentInformation]
  Future<Either<NotificationAlert, ConsentInformation>>
      requestConsentInformation();
}
