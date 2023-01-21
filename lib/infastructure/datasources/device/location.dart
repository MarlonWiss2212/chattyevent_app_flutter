import 'package:permission_handler/permission_handler.dart';
import 'package:geolocator/geolocator.dart';

abstract class LocationDatasource {
  Future<PermissionStatus> getLocationPermissionStatus();
  Future<PermissionStatus> requestLocationPermission();
  Future<Position> getCurrentLocation();
  Future<bool> locationServiceIsEnabled();
}

class LocationDatasourceImpl implements LocationDatasource {
  @override
  Future<Position> getCurrentLocation() async {
    return await Geolocator.getCurrentPosition();
  }

  @override
  Future<PermissionStatus> getLocationPermissionStatus() async {
    return await Permission.location.status;
  }

  @override
  Future<PermissionStatus> requestLocationPermission() async {
    return await Permission.location.request();
  }

  @override
  Future<bool> locationServiceIsEnabled() async {
    return await Geolocator.isLocationServiceEnabled();
  }
}
