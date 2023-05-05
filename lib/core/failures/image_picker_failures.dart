import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';

abstract class ImagePickerFailure {}

class ServiceLocationFailure extends ImagePickerFailure {}

class NoCameraPermissionFailure extends ImagePickerFailure {}

class NoPhotoTakenFailure extends ImagePickerFailure {}

class NoPhotosPermissionFailure extends ImagePickerFailure {}

class NoPhotoSelectedFailure extends ImagePickerFailure {}

class PhotoNotCroppedFailure extends ImagePickerFailure {}

NotificationAlert mapImagePickerFailureToNotificationAlert(
    ImagePickerFailure failure) {
  switch (failure.runtimeType) {
    case NoPhotosPermissionFailure:
      return NotificationAlert(
        title: "Keine Foto Berechtigung",
        message:
            "Bitte gib uns die Berechtigung für deine Fotos um dieses Feature nutzen zu können",
      );
    case PhotoNotCroppedFailure:
      return NotificationAlert(
        title: "Bild nicht zugeschnitten",
        message:
            "Bitte schneide das Bild zu um dieses Feature nutzen zu können",
      );
    case NoCameraPermissionFailure:
      return NotificationAlert(
        title: "Keine Kamera Berechtigung",
        message:
            "Bitte gib uns die Berechtigung für deine Kamera um dieses Feature nutzen zu können",
      );
    case NoPhotoTakenFailure:
      return NotificationAlert(
        title: "Kein Foto aufgenommen",
        message: "Bitte nim ein Foto auf um dieses Feature nutzen zu können",
      );
    case NoPhotoSelectedFailure:
      return NotificationAlert(
        title: "Kein Foto ausgewählt",
        message: "Bitte wähle ein Foto auf um dieses Feature nutzen zu können",
      );
    default:
      return NotificationAlert(
        title: "Image Picker Fehler",
        message: "Unerwarteter Fehler aufgetreten",
      );
  }
}
