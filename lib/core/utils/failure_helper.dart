import 'package:graphql/client.dart';
import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';

class FailureHelper {
  static NotificationAlert graphqlFailureToNotificationAlert({
    required String title,
    required QueryResult<Object?> response,
  }) {
    if (response.exception == null) {
      return NotificationAlert(
        title: "Fehler in der App",
        message: "Unerwarteter Fehler in der App",
      );
    }

    bool showDivider = false;
    String message = "";

    for (final error in response.exception!.graphqlErrors) {
      if (showDivider) {
        message += "| ";
      }
      showDivider = true;
      message += error.message;
    }

    return NotificationAlert(
      title: title,
      message: message,
      exception: response.exception,
    );
  }

  static NotificationAlert catchFailureToNotificationAlert({
    required Object exception,
  }) {
    return NotificationAlert(
      title: "Fehler in der App",
      message: exception.toString(),
    );
  }
}
