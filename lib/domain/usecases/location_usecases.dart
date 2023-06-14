import 'dart:io';

import 'package:chattyevent_app_flutter/domain/usecases/permission_usecases.dart';
import 'package:dartz/dartz.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:chattyevent_app_flutter/core/failures/location_failures.dart';
import 'package:chattyevent_app_flutter/domain/repositories/device/location_repository.dart';
import 'package:url_launcher/url_launcher_string.dart';

class LocationUseCases {
  final LocationRepository locationRepository;
  final PermissionUseCases permissionUseCases;
  LocationUseCases({
    required this.locationRepository,
    required this.permissionUseCases,
  });

  Future<bool> locationServiceIsEnabled() async {
    return await locationRepository.locationServiceIsEnabled();
  }

  Future<Either<NotificationAlert, Position>>
      getCurrentLocationWithPermissions() async {
    PermissionStatus permissionStatus =
        await permissionUseCases.getLocationPermissionStatus();

    if (await locationServiceIsEnabled() == false) {
      return Left(mapLocationFailureToNotificationAlert(
        ServiceLocationFailure(),
      ));
    }

    if (permissionStatus.isDenied) {
      permissionStatus = await permissionUseCases.requestLocationPermission();
    }

    if (permissionStatus.isPermanentlyDenied || permissionStatus.isDenied) {
      return Left(mapLocationFailureToNotificationAlert(
        NoLocationPermissionFailure(),
      ));
    }

    final location = await locationRepository.getCurrentLocation();

    return Right(location);
  }

  Future<Either<NotificationAlert, Unit>> openMaps({
    required String query,
  }) async {
    try {
      final String url =
          "https://www.google.com/maps/search/?api=1&query=$query";

      final worked = await launchUrlString(
        url,
        mode: Platform.isAndroid || Platform.isIOS
            ? LaunchMode.externalApplication
            : LaunchMode.platformDefault,
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
