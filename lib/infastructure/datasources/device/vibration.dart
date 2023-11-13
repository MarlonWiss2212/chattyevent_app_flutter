import 'package:vibration/vibration.dart';

abstract class VibrationDatasource {
  Future<void> vibrate({
    required int duration,
    required int intensity,
  });
  Future<bool> hasVibrator();
  Future<bool> hasCustomVibrationsSupport();
}

class VibrationDatasourceImpl implements VibrationDatasource {
  @override
  Future<bool> hasVibrator() async {
    return await Vibration.hasVibrator() ?? false;
  }

  @override
  Future<bool> hasCustomVibrationsSupport() async {
    return await Vibration.hasCustomVibrationsSupport() ?? false;
  }

  @override
  Future<void> vibrate({
    required int duration,
    required int intensity,
  }) async {
    return await Vibration.vibrate(
        duration: duration, intensities: [intensity]);
  }
}
