import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

Future<void> init() async {
  OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);
  OneSignal.shared.setAppId(dotenv.get("ONE_SIGNAL_APP_ID"));
  await OneSignal.shared.promptUserForPushNotificationPermission();
}

Future<void> setExternalUserId(String userId) async {
  await OneSignal.shared.setExternalUserId(userId);
}
