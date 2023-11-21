import 'package:geolocator/geolocator.dart';

abstract class LocationDatasource {
  Future<Position> getCurrentLocation();
  Future<bool> locationServiceIsEnabled();
}

class LocationDatasourceImpl implements LocationDatasource {
  @override
  Future<Position> getCurrentLocation() async {
    return await Geolocator.getCurrentPosition();
  }

  @override
  Future<bool> locationServiceIsEnabled() async {
    return await Geolocator.isLocationServiceEnabled();
  }
}
