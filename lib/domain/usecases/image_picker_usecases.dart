import 'dart:io';
import 'package:chattyevent_app_flutter/domain/repositories/device/permission_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:chattyevent_app_flutter/core/failures/image_picker_failures.dart';
import 'package:chattyevent_app_flutter/domain/repositories/device/image_picker_repository.dart';

class ImagePickerUseCases {
  final PermissionRepository permissionRepository;
  final ImagePickerRepository imagePickerRepository;
  ImagePickerUseCases({
    required this.imagePickerRepository,
    required this.permissionRepository,
  });

  Future<Either<NotificationAlert, File>> getImageFromCameraWithPermissions({
    CropAspectRatio? cropAspectRatio,
  }) async {
    PermissionStatus permissionStatus =
        await permissionRepository.getCameraPermissionStatus();

    if (permissionStatus.isDenied) {
      permissionStatus = await permissionRepository.requestCameraPermission();
    }

    if (permissionStatus.isPermanentlyDenied || permissionStatus.isDenied) {
      return Left(mapImagePickerFailureToNotificationAlert(
        NoCameraPermissionFailure(),
      ));
    }

    final image = await imagePickerRepository.getImageFromCamera();

    return await image.fold(
      (alert) => Left(alert),
      (image) async {
        if (cropAspectRatio != null) {
          final fileOrAlert = await imagePickerRepository.cropImage(
            sourcePath: image.path,
            aspectRatio: cropAspectRatio,
            compressQuality: 100,
          );
          return await fileOrAlert.fold(
            (alert) => Left(alert),
            (file) async {
              return await convertImageToJpgAndScaleTo720p(file: file);
            },
          );
        }
        return await convertImageToJpgAndScaleTo720p(file: image);
      },
    );
  }

  Future<Either<NotificationAlert, File>> getImageFromPhotosWithPermissions({
    CropAspectRatio? cropAspectRatio,
  }) async {
    final permissionStatus =
        await permissionRepository.getPhotosPermissionStatus();

    if (permissionStatus.isDenied || permissionStatus.isLimited) {
      await permissionRepository.requestPhotosPermission();
    }

    if (permissionStatus.isPermanentlyDenied || permissionStatus.isRestricted) {
      return Left(mapImagePickerFailureToNotificationAlert(
        NoPhotosPermissionFailure(),
      ));
    }

    final image = await imagePickerRepository.getImageFromGallery();

    return await image.fold(
      (alert) => Left(alert),
      (image) async {
        if (cropAspectRatio != null) {
          final fileOrAlert = await imagePickerRepository.cropImage(
            sourcePath: image.path,
            aspectRatio: cropAspectRatio,
            compressQuality: 100,
          );
          return await fileOrAlert.fold(
            (alert) => Left(alert),
            (file) async {
              return await convertImageToJpgAndScaleTo720p(file: file);
            },
          );
        }
        return await convertImageToJpgAndScaleTo720p(file: image);
      },
    );
  }

  Future<Either<NotificationAlert, File>> convertImageToJpgAndScaleTo720p({
    required File file,
  }) async {
    final imgOrAlert = await imagePickerRepository.fileToImage(file: file);
    return await imgOrAlert.fold(
      (alert) => Left(alert),
      (img) async {
        return await imagePickerRepository.convertPngToJpeg(
          image: img,
          oldPath: file.path,
        );
      },
    );
  }
}
