import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:chattyevent_app_flutter/core/utils/failure_helper.dart';
import 'package:chattyevent_app_flutter/domain/repositories/device/vibration_repository.dart';
import 'package:chattyevent_app_flutter/infastructure/datasources/device/vibration.dart';
import 'package:dartz/dartz.dart';

class VibrationRepositoryImpl implements VibrationRepository {
  final VibrationDatasource vibrationDatasource;
  VibrationRepositoryImpl({
    required this.vibrationDatasource,
  });

  @override
  Future<Either<NotificationAlert, Unit>> vibrate({
    int duration = 500,
    int amplitude = -1,
  }) async {
    try {
      await vibrationDatasource.vibrate(
        duration: duration,
        amplitude: amplitude,
      );
      return const Right(unit);
    } catch (e) {
      return Left(FailureHelper.catchFailureToNotificationAlert(exception: e));
    }
  }

  @override
  Future<Either<NotificationAlert, bool>> hasAmplitute() async {
    try {
      return Right(await vibrationDatasource.hasAmplitute());
    } catch (e) {
      return Left(FailureHelper.catchFailureToNotificationAlert(exception: e));
    }
  }

  @override
  Future<Either<NotificationAlert, bool>> hasVibrator() async {
    try {
      return Right(await vibrationDatasource.hasVibrator());
    } catch (e) {
      return Left(FailureHelper.catchFailureToNotificationAlert(exception: e));
    }
  }
}
