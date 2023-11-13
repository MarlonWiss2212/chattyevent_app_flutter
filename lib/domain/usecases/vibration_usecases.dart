import 'package:chattyevent_app_flutter/domain/repositories/device/vibration_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';

class VibrationUseCases {
  final VibrationRepository vibrationRepository;
  VibrationUseCases({required this.vibrationRepository});

  Future<Either<NotificationAlert, Unit>> vibrate({
    int duration = 500,
    int intensity = -1,
  }) async {
    final hasCustomVibrationsSupport =
        (await vibrationRepository.hasCustomVibrationsSupport()).fold(
      (alert) => false,
      (boolean) => boolean,
    );
    final hasVibrator = (await vibrationRepository.hasVibrator()).fold(
      (alert) => false,
      (boolean) => boolean,
    );

    if (hasVibrator) {
      await vibrationRepository.vibrate(
        duration: duration,
        intensity: hasCustomVibrationsSupport == true ? intensity : -1,
      );
      return const Right(unit);
    }
    return Left(
      NotificationAlert(
        title: "Kann nicht Vibrieren",
        message: "Da der Vibrationsmotor nicht angesteuert werden kann",
      ),
    );
  }
}
