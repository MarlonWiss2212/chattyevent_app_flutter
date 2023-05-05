import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';

abstract class LocationFailure {}

class ServiceLocationFailure extends LocationFailure {}

class NoLocationPermissionFailure extends LocationFailure {}

NotificationAlert mapLocationFailureToNotificationAlert(
    LocationFailure failure) {
  switch (failure.runtimeType) {
    case ServiceLocationFailure:
      return NotificationAlert(
        title: "Location Service Deaktiviert",
        message: "Bitte schalte den Location Service an",
      );
    case NoLocationPermissionFailure:
      return NotificationAlert(
        title: "Keine Standort Berechtigung",
        message:
            "Bitte gib uns die Berechtigung für deinen Standort um dieses Feature nutzen zu können",
      );
    default:
      return NotificationAlert(
        title: "Standort Fehler",
        message: "Unerwarteter Fehler aufgetreten",
      );
  }
}
