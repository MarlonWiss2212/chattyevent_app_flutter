import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

class OneSignalUtils {
  static Future<void> initialize() async {
    await OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
    OneSignal.initialize(dotenv.get("ONE_SIGNAL_APP_ID"));
  }
}
