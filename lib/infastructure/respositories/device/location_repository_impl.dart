import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:chattyevent_app_flutter/domain/repositories/device/location_repository.dart';
import 'package:chattyevent_app_flutter/infastructure/datasources/device/location.dart';
import 'package:url_launcher/url_launcher_string.dart';

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

  @override
  Future<Either<String, Unit>> openMaps({required String query}) async {
    try {
      final String url =
          "https://www.google.com/maps/search/?api=1&query=$query";

      if (await canLaunchUrlString(url) == true) {
        final LaunchMode mode = !kIsWeb
            ? Platform.isAndroid || Platform.isIOS
                ? LaunchMode.externalApplication
                : LaunchMode.platformDefault
            : LaunchMode.platformDefault;
        await launchUrlString(url, mode: mode);
        return const Right(unit);
      } else {
        return const Left("Konnte google maps nicht öffnen");
      }
    } catch (e) {
      return const Left("Konnte google maps nicht öffnen");
    }
  }
}
