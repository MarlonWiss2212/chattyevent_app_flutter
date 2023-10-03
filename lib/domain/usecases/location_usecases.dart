import 'dart:io';
import 'package:chattyevent_app_flutter/domain/repositories/device/permission_repository.dart';
import 'package:chattyevent_app_flutter/domain/usecases/launch_url_usecases.dart';
import 'package:dartz/dartz.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:chattyevent_app_flutter/core/failures/location_failures.dart';
import 'package:chattyevent_app_flutter/domain/repositories/device/location_repository.dart';
import 'package:url_launcher/url_launcher_string.dart';

class LocationUseCases {
  final LocationRepository locationRepository;
  final LaunchUrlUseCases launchUrlUseCases;
  final PermissionRepository permissionRepository;
  LocationUseCases({
    required this.locationRepository,
    required this.permissionRepository,
    required this.launchUrlUseCases,
  });

  Future<void> saveCurrentLocationLatLngToStorage({
    required LatLng latLng,
  }) async {
    return await locationRepository.saveCurrentLocationLatLngToStorage(
        latLng: latLng);
  }

  Future<Either<NotificationAlert, LatLng>>
      getCurrentLocationLatLngFromStorage() async {
    return await locationRepository.getCurrentLocationLatLngFromStorage();
  }

  Future<bool> locationServiceIsEnabled() async {
    return await locationRepository.locationServiceIsEnabled();
  }

  Future<Either<NotificationAlert, Position>>
      getCurrentLocationWithPermissions() async {
    PermissionStatus permissionStatus =
        await permissionRepository.getLocationPermissionStatus();

    if (await locationRepository.locationServiceIsEnabled() == false) {
      return Left(mapLocationFailureToNotificationAlert(
        ServiceLocationFailure(),
      ));
    }

    if (permissionStatus.isDenied) {
      permissionStatus = await permissionRepository.requestLocationPermission();
    }

    if (permissionStatus.isPermanentlyDenied || permissionStatus.isDenied) {
      return Left(mapLocationFailureToNotificationAlert(
        NoLocationPermissionFailure(),
      ));
    }
    final locationOrFailure = await locationRepository.getCurrentLocation();
    await locationOrFailure.fold(
      (_) => null,
      (position) async {
        await locationRepository.saveCurrentLocationLatLngToStorage(
          latLng: LatLng(
            position.latitude,
            position.longitude,
          ),
        );
      },
    );

    return locationOrFailure;
  }

  Future<Either<NotificationAlert, Unit>> openMaps({
    String? query,
    LatLng? latLng,
  }) async {
    final String url =
        "https://www.google.com/maps/search/?api=1${latLng != null ? "&query=${latLng.latitude},${latLng.longitude}" : ''}${query != null ? '&query=$query' : ''}";

    return await launchUrlUseCases.launchUrl(
      url: url,
      launchMode: Platform.isAndroid || Platform.isIOS
          ? LaunchMode.externalApplication
          : LaunchMode.platformDefault,
    );
  }
}
