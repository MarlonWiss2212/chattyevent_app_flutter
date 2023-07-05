import 'package:chattyevent_app_flutter/domain/repositories/device/vibration_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';

class VibrationUseCases {
  final VibrationRepository vibrationRepository;
  VibrationUseCases({required this.vibrationRepository});

  Future<Either<NotificationAlert, Unit>> vibrate({
    int duration = 500,
    int amplitude = -1,
  }) async {
    final hasVibrator = await vibrationRepository.hasVibrator();

    return await hasVibrator.fold(
      (alert) => Left(alert),
      (boolean) async {
        if (boolean == false) return const Right(unit);
        final vibrate = await vibrationRepository.vibrate(
          duration: duration,
          amplitude: amplitude,
        );

        return vibrate;
      },
    );
  }
}
