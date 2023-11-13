import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:dartz/dartz.dart';

abstract class VibrationRepository {
  Future<Either<NotificationAlert, bool>> hasVibrator();
  Future<Either<NotificationAlert, bool>> hasCustomVibrationsSupport();
  Future<Either<NotificationAlert, Unit>> vibrate({
    int duration = 500,
    int intensity = -1,
  });
}
