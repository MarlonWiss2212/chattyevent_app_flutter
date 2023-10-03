import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:dartz/dartz.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract class LocationRepository {
  Future<Either<NotificationAlert, Position>> getCurrentLocation();
  Future<bool> locationServiceIsEnabled();
  Future<void> saveCurrentLocationLatLngToStorage({
    required LatLng latLng,
  });
  Future<Either<NotificationAlert, LatLng>>
      getCurrentLocationLatLngFromStorage();
}
