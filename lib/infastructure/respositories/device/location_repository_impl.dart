import 'dart:convert';

import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:chattyevent_app_flutter/core/utils/failure_helper.dart';
import 'package:chattyevent_app_flutter/infastructure/datasources/local/sharedPreferences.dart';
import 'package:dartz/dartz.dart';
import 'package:geolocator/geolocator.dart';
import 'package:chattyevent_app_flutter/domain/repositories/device/location_repository.dart';
import 'package:chattyevent_app_flutter/infastructure/datasources/device/location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationRepositoryImpl implements LocationRepository {
  final SharedPreferencesDatasource sharedPrefrencesDatasource;
  final LocationDatasource locationDatasource;
  LocationRepositoryImpl({
    required this.locationDatasource,
    required this.sharedPrefrencesDatasource,
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
  Future<Either<NotificationAlert, LatLng>>
      getCurrentLocationLatLngFromStorage() async {
    try {
      final response = await sharedPrefrencesDatasource.getStringFromStorage(
        "currentLocationLatLng",
      );
      return response.fold(
        (alert) => Left(alert),
        (value) {
          final List<dynamic> convertedJson = json.decode(value);
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
        },
      );
    } catch (e) {
      return Left(FailureHelper.catchFailureToNotificationAlert(exception: e));
    }
  }

  @override
  Future<void> saveCurrentLocationLatLngToStorage({
    required LatLng latLng,
  }) async {
    return await sharedPrefrencesDatasource.saveStringToStorage(
      "currentLocationLatLng",
      json.encode(latLng.toJson()),
    );
  }
}
