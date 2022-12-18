import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

Future<void> init() async {
  OneSignal.shared.setAppId(dotenv.get("ONE_SIGNAL_APP_ID"));
}

Future<void> setExternalUserId(String userId) async {
  await OneSignal.shared.setExternalUserId(userId);
}

Future<void> promptUserForPushNotificationPermission() async {
  await OneSignal.shared.promptUserForPushNotificationPermission();
}
