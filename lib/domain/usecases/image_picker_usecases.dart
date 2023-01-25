import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:social_media_app_flutter/domain/failures/image_picker_failures.dart';
import 'package:social_media_app_flutter/domain/repositories/device/image_picker_repository.dart';

class ImagePickerUseCases {
  final ImagePickerRepository imagePickerRepository;
  ImagePickerUseCases({required this.imagePickerRepository});

  Future<PermissionStatus> requestCameraPermission() async {
    return await imagePickerRepository.requestCameraPermission();
  }

  Future<PermissionStatus> getCameraPermissionStatus() async {
    return await imagePickerRepository.getCameraPermissionStatus();
  }

  Future<PermissionStatus> requestPhotosPermission() async {
    return await imagePickerRepository.requestPhotosPermission();
  }

  Future<PermissionStatus> getPhotosPermissionStatus() async {
    return await imagePickerRepository.getPhotosPermissionStatus();
  }

  Future<Either<ImagePickerFailure, File>> getImageFromCameraWithPermissions({
    CropAspectRatio? cropAspectRatio,
  }) async {
    PermissionStatus permissionStatus = await getCameraPermissionStatus();

    if (permissionStatus.isDenied) {
      permissionStatus = await requestCameraPermission();
    }

    if (permissionStatus.isPermanentlyDenied || permissionStatus.isDenied) {
      return Left(NoCameraPermissionFailure());
    }

    final image = await imagePickerRepository.getImageFromCamera();

    if (image == null) {
      return Left(NoPhotoTakenFailure());
    }

    if (cropAspectRatio != null) {
      final croppedImage = await ImageCropper().cropImage(
        sourcePath: image.path,
        aspectRatio: cropAspectRatio,
      );

      if (croppedImage != null) {
        return Right(File(croppedImage.path));
      }

      return Left(PhotoNotCroppedFailure());
    }

    return Right(File(image.path));
  }

  Future<Either<ImagePickerFailure, File>> getImageFromPhotosWithPermissions({
    CropAspectRatio? cropAspectRatio,
  }) async {
    final permissionStatus = await getPhotosPermissionStatus();

    if (permissionStatus.isDenied || permissionStatus.isLimited) {
      await requestPhotosPermission();
    }

    if (permissionStatus.isPermanentlyDenied || permissionStatus.isRestricted) {
      return Left(NoPhotosPermissionFailure());
    }

    final image = await imagePickerRepository.getImageFromGallery();

    if (image == null) {
      return Left(NoPhotoSelectedFailure());
    }

    if (cropAspectRatio != null) {
      final croppedImage = await ImageCropper().cropImage(
        sourcePath: image.path,
        aspectRatio: cropAspectRatio,
      );

      if (croppedImage != null) {
        return Right(File(croppedImage.path));
      }

      return Left(PhotoNotCroppedFailure());
    }

    return Right(File(image.path));
  }
}
