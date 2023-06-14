import 'package:permission_handler/permission_handler.dart';

class PermissionUseCases {
  //Notification
  Future<PermissionStatus> getNotificationPermissionStatus() async {
    return await Permission.notification.status;
  }

  Future<PermissionStatus> requestNotificationPermission() async {
    return await Permission.notification.request();
  }

  //Location
  Future<PermissionStatus> getLocationPermissionStatus() async {
    return await Permission.location.status;
  }

  Future<PermissionStatus> requestLocationPermission() async {
    return await Permission.location.request();
  }

  //Camera
  Future<PermissionStatus> requestCameraPermission() async {
    return await Permission.camera.request();
  }

  Future<PermissionStatus> getCameraPermissionStatus() async {
    return await Permission.camera.status;
  }

  //Photos
  Future<PermissionStatus> requestPhotosPermission() async {
    return await Permission.photos.request();
  }

  Future<PermissionStatus> getPhotosPermissionStatus() async {
    return await Permission.photos.status;
  }
}
