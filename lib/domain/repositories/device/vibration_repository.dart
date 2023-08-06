import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:dartz/dartz.dart';

abstract class VibrationRepository {
  Future<Either<NotificationAlert, bool>> hasVibrator();
  Future<Either<NotificationAlert, bool>> hasAmplitute();
  Future<Either<NotificationAlert, Unit>> vibrate({
    int duration = 500,
    int amplitude = -1,
  });
}
