import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:chattyevent_app_flutter/infastructure/datasources/local/weblink.dart';
import 'package:dartz/dartz.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:chattyevent_app_flutter/domain/repositories/device/location_repository.dart';
import 'package:chattyevent_app_flutter/infastructure/datasources/device/location.dart';

class LocationRepositoryImpl implements LocationRepository {
  final LocationDatasource locationDatasource;
  final WeblinkDatasource weblinkDatasource;
  LocationRepositoryImpl({
    required this.locationDatasource,
    required this.weblinkDatasource,
  });

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

  @override
  Future<Either<NotificationAlert, Unit>> openMaps({
    required String query,
  }) async {
    try {
      final String url =
          "https://www.google.com/maps/search/?api=1&query=$query";

      final worked = await weblinkDatasource.launchUrl(
        url: url,
        otherApp: true,
      );
      if (worked == false) {
        return Left(
          NotificationAlert(
            message: "Konnte google maps nicht öffnen",
            title: "Google Maps Fehler",
          ),
        );
      }
      return const Right(unit);
    } catch (e) {
      return Left(
        NotificationAlert(
          message: "Konnte google maps nicht öffnen",
          title: "Google Maps Fehler",
        ),
      );
    }
  }
}
