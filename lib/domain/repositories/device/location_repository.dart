import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:dartz/dartz.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

abstract class LocationRepository {
  Future<PermissionStatus> getLocationPermissionStatus();
  Future<PermissionStatus> requestLocationPermission();
  Future<Position> getCurrentLocation();
  Future<bool> locationServiceIsEnabled();
  Future<Either<NotificationAlert, Unit>> openMaps({required String query});
}
