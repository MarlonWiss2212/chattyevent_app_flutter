import 'package:dartz/dartz.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

abstract class LocationRepository {
  Future<PermissionStatus> getLocationPermissionStatus();
  Future<PermissionStatus> requestLocationPermission();
  Future<Position> getCurrentLocation();
  Future<bool> locationServiceIsEnabled();
  Future<Either<String, Unit>> openMaps({required String query});
}
