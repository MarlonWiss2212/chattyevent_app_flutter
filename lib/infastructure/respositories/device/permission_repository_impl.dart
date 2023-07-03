import 'package:chattyevent_app_flutter/domain/repositories/device/permission_repository.dart';
import 'package:chattyevent_app_flutter/infastructure/datasources/device/permission.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionRepositoryImpl implements PermissionRepository {
  final PermissionDatasource permissionDatasource;
  PermissionRepositoryImpl({required this.permissionDatasource});

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
}
