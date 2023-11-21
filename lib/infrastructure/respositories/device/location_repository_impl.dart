import 'dart:convert';
import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:chattyevent_app_flutter/core/utils/failure_helper.dart';
import 'package:chattyevent_app_flutter/infrastructure/datasources/local/persist_hive_datasource.dart';
import 'package:dartz/dartz.dart';
import 'package:geolocator/geolocator.dart';
import 'package:chattyevent_app_flutter/domain/repositories/device/location_repository.dart';
import 'package:chattyevent_app_flutter/infrastructure/datasources/device/location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationRepositoryImpl implements LocationRepository {
  final PersistHiveDatasource persistHiveDatasource;
  final LocationDatasource locationDatasource;
  LocationRepositoryImpl({
    required this.locationDatasource,
    required this.persistHiveDatasource,
  });

  @override
  Future<Either<NotificationAlert, Position>> getCurrentLocation() async {
    try {
      return Right(await locationDatasource.getCurrentLocation());
    } catch (e) {
      return Left(FailureHelper.catchFailureToNotificationAlert(exception: e));
    }
  }

  @override
  Future<bool> locationServiceIsEnabled() async {
    return await locationDatasource.locationServiceIsEnabled();
  }

  @override
  Either<NotificationAlert, LatLng> getCurrentLocationLatLngFromStorage() {
    try {
      final String response = persistHiveDatasource.get<String>(
        key: "currentLocationLatLng",
      );

      final List<dynamic> convertedJson = json.decode(response);
      final LatLng? convertedLatLng = LatLng.fromJson(convertedJson);
      if (convertedLatLng != null) {
        return Right(convertedLatLng);
      }
      return Left(
        NotificationAlert(
          title: "Location Fehler",
          message: "Fehler beim konvertieren vom JSON",
        ),
      );
    } catch (e) {
      return Left(FailureHelper.catchFailureToNotificationAlert(exception: e));
    }
  }

  @override
  Future<void> saveCurrentLocationLatLngToStorage({
    required LatLng latLng,
  }) async {
    return await persistHiveDatasource.put<String>(
      key: "currentLocationLatLng",
      value: json.encode(latLng.toJson()),
    );
  }
}
