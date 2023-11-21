import 'package:permission_handler/permission_handler.dart';

abstract class PermissionDatasource {
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

class PermissionDatasourceImpl implements PermissionDatasource {
  @override
  Future<PermissionStatus> getNotificationPermissionStatus() async {
    return await Permission.notification.status;
  }

  @override
  Future<PermissionStatus> requestNotificationPermission() async {
    return await Permission.notification.request();
  }

  //Location
  @override
  Future<PermissionStatus> getLocationPermissionStatus() async {
    return await Permission.location.status;
  }

  @override
  Future<PermissionStatus> requestLocationPermission() async {
    return await Permission.location.request();
  }

  //Camera
  @override
  Future<PermissionStatus> requestCameraPermission() async {
    return await Permission.camera.request();
  }

  @override
  Future<PermissionStatus> getCameraPermissionStatus() async {
    return await Permission.camera.status;
  }

  //Photos
  @override
  Future<PermissionStatus> requestPhotosPermission() async {
    return await Permission.photos.request();
  }

  @override
  Future<PermissionStatus> getPhotosPermissionStatus() async {
    return await Permission.photos.status;
  }

  ////Photos
  @override
  Future<PermissionStatus> requestMicrophonePermission() async {
    return await Permission.microphone.request();
  }

  @override
  Future<PermissionStatus> getMicrophonePermissionStatus() async {
    return await Permission.microphone.status;
  }
}
