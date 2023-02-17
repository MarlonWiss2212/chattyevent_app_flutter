import 'package:dartz/dartz.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:social_media_app_flutter/core/failures/location_failures.dart';
import 'package:social_media_app_flutter/domain/repositories/device/location_repository.dart';

class LocationUseCases {
  final LocationRepository locationRepository;
  LocationUseCases({required this.locationRepository});

  Future<PermissionStatus> getLocationPermissionStatus() async {
    return await locationRepository.getLocationPermissionStatus();
  }

  Future<PermissionStatus> requestLocationPermission() async {
    return await locationRepository.requestLocationPermission();
  }

  Future<bool> locationServiceIsEnabled() async {
    return await locationRepository.locationServiceIsEnabled();
  }

  Future<Either<LocationFailure, Position>>
      getCurrentLocationWithPermissions() async {
    PermissionStatus permissionStatus = await getLocationPermissionStatus();

    if (await locationServiceIsEnabled() == false) {
      return Left(ServiceLocationFailure());
    }

    if (permissionStatus.isDenied) {
      permissionStatus = await requestLocationPermission();
    }

    if (permissionStatus.isPermanentlyDenied || permissionStatus.isDenied) {
      return Left(NoLocationPermissionFailure());
    }

    final location = await locationRepository.getCurrentLocation();

    return Right(location);
  }
}
