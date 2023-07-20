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
      if (amplitude != -1) {
        final hasAmplitute = await vibrationDatasource.hasAmplitute();
        if (!hasAmplitute) {
          return Left(
            NotificationAlert(
              title: "Kann nicht Vibrieren",
              message:
                  "Da der Vibrationsmotor keine erweiterte Steuerung unterstützt",
            ),
          );
        }
      }
      if (await vibrationDatasource.hasVibrator()) {
        await vibrationDatasource.vibrate(
          duration: duration,
          amplitude: amplitude,
        );
        return const Right(unit);
      }
      return Left(
        NotificationAlert(
          title: "Kann nicht Vibrieren",
          message: "Da der Vibrationsmotor nicht angesteuert werden kann",
        ),
      );
    } catch (e) {
      return Left(FailureHelper.catchFailureToNotificationAlert(exception: e));
    }
  }
}
