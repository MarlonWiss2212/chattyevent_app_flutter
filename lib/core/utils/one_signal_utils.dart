import 'package:chattyevent_app_flutter/core/enums/notification/notification_type_enum.dart';
import 'package:chattyevent_app_flutter/presentation/router/router.gr.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

class OneSignalUtils {
  static Future<void> initialize() async {
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

  static void setNotificationReceivedHandler(AppRouter appRouter) {
    OneSignal.shared.setNotificationWillShowInForegroundHandler((event) {
      final Map<String, dynamic>? additionalData =
          event.notification.additionalData;
      if (additionalData == null) {
        event.complete(event.notification);
        return;
      }

      final currentPath = appRouter.currentPath;
      if (currentPath == additionalData["route"]) {
        final NotificationTypeEnum? type = additionalData["type"] != null
            ? NotificationTypeEnumExtension.fromValue(additionalData["type"])
            : null;

        if (type == NotificationTypeEnum.messageadded) {
          event.complete(null);
          return;
        }
      }

      event.complete(event.notification);
    });
  }
}
