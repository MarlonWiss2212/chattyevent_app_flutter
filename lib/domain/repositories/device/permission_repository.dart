import 'package:permission_handler/permission_handler.dart';

abstract class PermissionRepository {
  //Notification
  Future<PermissionStatus> getNotificationPermissionStatus();
  Future<PermissionStatus> requestNotificationPermission();
  //Location
  Future<PermissionStatus> getLocationPermissionStatus();
  Future<PermissionStatus> requestLocationPermission();
  //Camera
  Future<PermissionStatus> requestCameraPermission();
  Future<PermissionStatus> getCameraPermissionStatus();
  //Photos
  Future<PermissionStatus> requestPhotosPermission();
  Future<PermissionStatus> getPhotosPermissionStatus();
  //Microphone
  Future<PermissionStatus> requestMicrophonePermission();
  Future<PermissionStatus> getMicrophonePermissionStatus();
}
