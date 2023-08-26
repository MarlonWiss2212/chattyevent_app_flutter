import 'package:chattyevent_app_flutter/core/enums/notification/notification_type_enum.dart';
import 'package:chattyevent_app_flutter/presentation/router/router.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

class OneSignalUtils {
  static Future<void> initialize() async {
    await OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
    OneSignal.initialize(dotenv.get("ONE_SIGNAL_APP_ID"));
  }

  static Future<void> login(String userId) async {
    await OneSignal.login(userId);
  }

  static Future<void> logout() async {
    await OneSignal.logout();
  }

  static void setNotificationOpenedHandler(AppRouter appRouter) {
    OneSignal.Notifications.addClickListener((event) {
      final String? route = event.notification.additionalData?['route'];
      if (route != null) {
        appRouter.pushNamed(route);
      }
    });
  }

  static void setNotificationReceivedHandler(AppRouter appRouter) {
    OneSignal.Notifications.addForegroundWillDisplayListener((event) {
      event.preventDefault();

      final Map<String, dynamic>? additionalData =
          event.notification.additionalData;
      if (additionalData == null) {
        event.notification.display();
        return;
      }

      final currentPath = appRouter.currentPath;
      if (currentPath == additionalData["route"]) {
        final NotificationTypeEnum? type = additionalData["type"] != null
            ? NotificationTypeEnumExtension.fromValue(additionalData["type"])
            : null;

        if (type == NotificationTypeEnum.messageadded) {
          return;
        }
      }

      event.notification.display();
    });
  }
}
