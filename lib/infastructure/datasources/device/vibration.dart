import 'package:vibration/vibration.dart';

abstract class VibrationDatasource {
  Future<void> vibrate({
    required int duration,
    required int amplitude,
  });
  Future<bool?> hasVibrator();
}

class VibrationDatasourceImpl implements VibrationDatasource {
  @override
  Future<bool?> hasVibrator() async {
    return await Vibration.hasVibrator();
  }

  @override
  Future<void> vibrate({
    required int duration,
    required int amplitude,
  }) async {
    return await Vibration.vibrate(duration: duration, amplitude: amplitude);
  }
}
