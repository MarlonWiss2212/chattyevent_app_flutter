import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:dartz/dartz.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract class LocationRepository {
  /// Either return a NotificationAlert when an error occurred or
  /// returns the current position
  Future<Either<NotificationAlert, Position>> getCurrentLocation();

  /// checks if the location service is enabled and returns true if so
  Future<bool> locationServiceIsEnabled();

  /// saves the current [latLng] in the storage
  Future<void> saveCurrentLocationLatLngToStorage({
    required LatLng latLng,
  });

  /// Either return a NotificationAlert when an error occurred or
  /// returns the current LatLng from the Storage
  Either<NotificationAlert, LatLng> getCurrentLocationLatLngFromStorage();
}
