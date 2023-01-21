import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:social_media_app_flutter/domain/repositories/device/location_repository.dart';
import 'package:social_media_app_flutter/infastructure/datasources/device/location.dart';

class LocationRepositoryImpl implements LocationRepository {
  final LocationDatasource locationDatasource;
  LocationRepositoryImpl({required this.locationDatasource});

  @override
  Future<Position> getCurrentLocation() async {
    return await locationDatasource.getCurrentLocation();
  }

  @override
  Future<PermissionStatus> getLocationPermissionStatus() async {
    return await locationDatasource.getLocationPermissionStatus();
  }

  @override
  Future<PermissionStatus> requestLocationPermission() async {
    return await locationDatasource.requestLocationPermission();
  }

  @override
  Future<bool> locationServiceIsEnabled() async {
    return await locationDatasource.locationServiceIsEnabled();
  }
}
