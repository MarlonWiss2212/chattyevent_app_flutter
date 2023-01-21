import 'package:social_media_app_flutter/domain/entities/error_with_title_and_message.dart';

abstract class LocationFailure {}

class ServiceLocationFailure extends LocationFailure {}

class NoLocationPermissionFailure extends LocationFailure {}

ErrorWithTitleAndMessage mapLocationFailureToErrorWithTitleAndMessage(
    LocationFailure failure) {
  switch (failure.runtimeType) {
    case ServiceLocationFailure:
      return ErrorWithTitleAndMessage(
        title: "Location Service Deaktiviert",
        message: "Bitte schalte den Location Service an",
      );
    case NoLocationPermissionFailure:
      return ErrorWithTitleAndMessage(
        title: "Keine Standort Berechtigung",
        message:
            "Bitte gib uns die Berechtigung für deinen Standort um dieses Feature nutzen zu können",
      );
    default:
      return ErrorWithTitleAndMessage(
        title: "Standort Fehler",
        message: "Unerwarteter Fehler aufgetreten",
      );
  }
}
