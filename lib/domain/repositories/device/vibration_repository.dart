import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:dartz/dartz.dart';

abstract class VibrationRepository {
  /// Checks if there is a vibrator and <br /><br />
  /// either return a NotificationAlert when an error occurred or
  /// returns the state if there is a vibrator
  Future<Either<NotificationAlert, bool>> hasVibrator();

  /// Checks if there is a custom vibration support <br /><br />
  /// either return a NotificationAlert when an error occurred or
  /// returns the state if there is a custom vibration support
  Future<Either<NotificationAlert, bool>> hasCustomVibrationsSupport();

  /// Starts to vibrate with the given [duration] and [intensity] and <br /><br />
  /// either return a NotificationAlert when an error occurred or
  /// returns Unit when it worked
  Future<Either<NotificationAlert, Unit>> vibrate({
    int duration = 500,
    int intensity = -1,
  });
}
