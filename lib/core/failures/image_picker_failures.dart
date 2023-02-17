import 'package:social_media_app_flutter/domain/entities/error_with_title_and_message.dart';

abstract class ImagePickerFailure {}

class ServiceLocationFailure extends ImagePickerFailure {}

class NoCameraPermissionFailure extends ImagePickerFailure {}

class NoPhotoTakenFailure extends ImagePickerFailure {}

class NoPhotosPermissionFailure extends ImagePickerFailure {}

class NoPhotoSelectedFailure extends ImagePickerFailure {}

class PhotoNotCroppedFailure extends ImagePickerFailure {}

ErrorWithTitleAndMessage mapImagePickerFailureToErrorWithTitleAndMessage(
    ImagePickerFailure failure) {
  switch (failure.runtimeType) {
    case NoPhotosPermissionFailure:
      return ErrorWithTitleAndMessage(
        title: "Keine Foto Berechtigung",
        message:
            "Bitte gib uns die Berechtigung für deine Fotos um dieses Feature nutzen zu können",
      );
    case PhotoNotCroppedFailure:
      return ErrorWithTitleAndMessage(
        title: "Bild nicht zugeschnitten",
        message:
            "Bitte schneide das Bild zu um dieses Feature nutzen zu können",
      );
    case NoCameraPermissionFailure:
      return ErrorWithTitleAndMessage(
        title: "Keine Kamera Berechtigung",
        message:
            "Bitte gib uns die Berechtigung für deine Kamera um dieses Feature nutzen zu können",
      );
    case NoPhotoTakenFailure:
      return ErrorWithTitleAndMessage(
        title: "Kein Foto aufgenommen",
        message: "Bitte nim ein Foto auf um dieses Feature nutzen zu können",
      );
    case NoPhotoSelectedFailure:
      return ErrorWithTitleAndMessage(
        title: "Kein Foto ausgewählt",
        message: "Bitte wähle ein Foto auf um dieses Feature nutzen zu können",
      );
    default:
      return ErrorWithTitleAndMessage(
        title: "Image Picker Fehler",
        message: "Unerwarteter Fehler aufgetreten",
      );
  }
}
