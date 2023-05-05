import 'package:graphql/client.dart';
import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';

class FailureHelper {
  static NotificationAlert graphqlFailureToNotificationAlert({
    required String title,
    required OperationException exception,
  }) {
    String message = "";

    for (final error in exception.graphqlErrors) {
      message += "${error.message} |";
    }

    return NotificationAlert(title: title, message: message);
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
