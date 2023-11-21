import 'package:chattyevent_app_flutter/domain/repositories/device/permission_repository.dart';
import 'package:chattyevent_app_flutter/infrastructure/datasources/device/permission.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionRepositoryImpl implements PermissionRepository {
  final PermissionDatasource permissionDatasource;
  PermissionRepositoryImpl({required this.permissionDatasource});

  @override
  Future<PermissionStatus> getNotificationPermissionStatus() async {
    return await permissionDatasource.getNotificationPermissionStatus();
  }

  @override
  Future<PermissionStatus> requestNotificationPermission() async {
    return await permissionDatasource.requestNotificationPermission();
  }

  //Location
  @override
  Future<PermissionStatus> getLocationPermissionStatus() async {
    return await permissionDatasource.getLocationPermissionStatus();
  }

  @override
  Future<PermissionStatus> requestLocationPermission() async {
    return await permissionDatasource.requestLocationPermission();
  }

  //Camera
  @override
  Future<PermissionStatus> requestCameraPermission() async {
    return await permissionDatasource.requestCameraPermission();
  }

  @override
  Future<PermissionStatus> getCameraPermissionStatus() async {
    return await permissionDatasource.getCameraPermissionStatus();
  }

  //Photos
  @override
  Future<PermissionStatus> requestPhotosPermission() async {
    return await permissionDatasource.requestPhotosPermission();
  }

  @override
  Future<PermissionStatus> getPhotosPermissionStatus() async {
    return await permissionDatasource.getPhotosPermissionStatus();
  }

  @override
  Future<PermissionStatus> requestMicrophonePermission() async {
    return await permissionDatasource.requestMicrophonePermission();
  }

  @override
  Future<PermissionStatus> getMicrophonePermissionStatus() async {
    return await permissionDatasource.getMicrophonePermissionStatus();
  }
}
