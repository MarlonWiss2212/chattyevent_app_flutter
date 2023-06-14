import 'dart:io';

import 'package:chattyevent_app_flutter/domain/usecases/permission_usecases.dart';
import 'package:dartz/dartz.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:chattyevent_app_flutter/core/failures/image_picker_failures.dart';
import 'package:chattyevent_app_flutter/domain/repositories/device/image_picker_repository.dart';

class ImagePickerUseCases {
  final ImageCropper _cropper = ImageCropper();

  final PermissionUseCases permissionUseCases;
  final ImagePickerRepository imagePickerRepository;
  ImagePickerUseCases({
    required this.imagePickerRepository,
    required this.permissionUseCases,
  });

  Future<CroppedFile?> cropImage({
    required String sourcePath,
    required int compressQuality,
    required CropAspectRatio aspectRatio,
  }) {
    return _cropper.cropImage(
      sourcePath: sourcePath,
      compressQuality: compressQuality,
      aspectRatio: aspectRatio,
    );
  }

  Future<Either<NotificationAlert, File>> getImageFromCameraWithPermissions({
    CropAspectRatio? cropAspectRatio,

    /// 0 to 100
    int quality = 50,
  }) async {
    PermissionStatus permissionStatus =
        await permissionUseCases.getCameraPermissionStatus();

    if (permissionStatus.isDenied) {
      permissionStatus = await permissionUseCases.requestCameraPermission();
    }

    if (permissionStatus.isPermanentlyDenied || permissionStatus.isDenied) {
      return Left(mapImagePickerFailureToNotificationAlert(
        NoCameraPermissionFailure(),
      ));
    }

    final image = await imagePickerRepository.getImageFromCamera();

    if (image == null) {
      return Left(mapImagePickerFailureToNotificationAlert(
        NoPhotoTakenFailure(),
      ));
    }

    if (cropAspectRatio != null) {
      final croppedImage = await cropImage(
        sourcePath: image.path,
        aspectRatio: cropAspectRatio,
        compressQuality: quality,
      );

      if (croppedImage != null) {
        return Right(File(croppedImage.path));
      }

      return Left(mapImagePickerFailureToNotificationAlert(
        PhotoNotCroppedFailure(),
      ));
    }

    return Right(File(image.path));
  }

  Future<Either<NotificationAlert, File>> getImageFromPhotosWithPermissions({
    CropAspectRatio? cropAspectRatio,

    /// 0 to 100
    int quality = 50,
  }) async {
    final permissionStatus =
        await permissionUseCases.getPhotosPermissionStatus();

    if (permissionStatus.isDenied || permissionStatus.isLimited) {
      await permissionUseCases.requestPhotosPermission();
    }

    if (permissionStatus.isPermanentlyDenied || permissionStatus.isRestricted) {
      return Left(mapImagePickerFailureToNotificationAlert(
        NoPhotosPermissionFailure(),
      ));
    }

    final image = await imagePickerRepository.getImageFromGallery();

    if (image == null) {
      return Left(mapImagePickerFailureToNotificationAlert(
        NoPhotoSelectedFailure(),
      ));
    }

    if (cropAspectRatio != null) {
      final croppedImage = await cropImage(
        sourcePath: image.path,
        aspectRatio: cropAspectRatio,
        compressQuality: quality,
      );

      if (croppedImage != null) {
        return Right(File(croppedImage.path));
      }

      return Left(mapImagePickerFailureToNotificationAlert(
        PhotoNotCroppedFailure(),
      ));
    }

    return Right(File(image.path));
  }
}
