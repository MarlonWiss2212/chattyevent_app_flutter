import 'package:chattyevent_app_flutter/presentation/router/router.gr.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

class OneSignalUtils {
  static Future<void> init() async {
    await OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);
    await OneSignal.shared.setAppId(dotenv.get("ONE_SIGNAL_APP_ID"));
  }

  static Future<void> setExternalUserId(String userId) async {
    await OneSignal.shared.removeExternalUserId();
    await OneSignal.shared.setExternalUserId(userId);
  }

  static void setNotificationOpenedHandler(AppRouter appRouter) {
    OneSignal.shared.setNotificationOpenedHandler((result) {
      String? route = result.notification.additionalData?['route'];

      if (route != null) {
        appRouter.pushNamed(route);
      }
    });
  }
}
