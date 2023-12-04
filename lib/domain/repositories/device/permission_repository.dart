import 'package:permission_handler/permission_handler.dart';

abstract class PermissionRepository {
  /// checks the current status of the notification permission.
  Future<PermissionStatus> getNotificationPermissionStatus();

  ///Request the user for access to the notification permission, if access hasn't already been grant access before.
  Future<PermissionStatus> requestNotificationPermission();

  /// checks the current status of the location permission.
  Future<PermissionStatus> getLocationPermissionStatus();

  ///Request the user for access to the location permission, if access hasn't already been grant access before.
  Future<PermissionStatus> requestLocationPermission();

  ///Request the user for access to the camera permission, if access hasn't already been grant access before.
  Future<PermissionStatus> requestCameraPermission();

  /// checks the current status of the notification permission.
  Future<PermissionStatus> getCameraPermissionStatus();

  ///Request the user for access to the photos permission, if access hasn't already been grant access before.
  Future<PermissionStatus> requestPhotosPermission();

  /// checks the current status of the photo permission.
  Future<PermissionStatus> getPhotosPermissionStatus();

  ///Request the user for access to the microphone permission, if access hasn't already been grant access before.
  Future<PermissionStatus> requestMicrophonePermission();

  /// checks the current status of the microphone permission.
  Future<PermissionStatus> getMicrophonePermissionStatus();
}
