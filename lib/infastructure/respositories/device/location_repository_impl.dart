import 'package:geolocator/geolocator.dart';
import 'package:chattyevent_app_flutter/domain/repositories/device/location_repository.dart';
import 'package:chattyevent_app_flutter/infastructure/datasources/device/location.dart';

class LocationRepositoryImpl implements LocationRepository {
  final LocationDatasource locationDatasource;
  LocationRepositoryImpl({
    required this.locationDatasource,
  });

  @override
  Future<Position> getCurrentLocation() async {
    return await locationDatasource.getCurrentLocation();
  }

  @override
  Future<bool> locationServiceIsEnabled() async {
    return await locationDatasource.locationServiceIsEnabled();
  }
}
