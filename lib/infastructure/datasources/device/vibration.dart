import 'package:vibration/vibration.dart';

abstract class VibrationDatasource {
  Future<void> vibrate({
    required int duration,
    required int amplitude,
  });
  Future<bool> hasVibrator();
  Future<bool> hasAmplitute();
}

class VibrationDatasourceImpl implements VibrationDatasource {
  @override
  Future<bool> hasVibrator() async {
    return await Vibration.hasVibrator() ?? false;
  }

  @override
  Future<bool> hasAmplitute() async {
    return await Vibration.hasAmplitudeControl() ?? false;
  }

  @override
  Future<void> vibrate({
    required int duration,
    required int amplitude,
  }) async {
    return await Vibration.vibrate(duration: duration, amplitude: amplitude);
  }
}
