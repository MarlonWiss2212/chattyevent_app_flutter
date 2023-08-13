import 'dart:io';
import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:chattyevent_app_flutter/core/failures/image_picker_failures.dart';
import 'package:chattyevent_app_flutter/core/utils/failure_helper.dart';
import 'package:dartz/dartz.dart';
import 'package:chattyevent_app_flutter/domain/repositories/device/image_picker_repository.dart';
import 'package:chattyevent_app_flutter/infastructure/datasources/device/image_picker.dart';
import 'package:image/image.dart';
import 'package:image_cropper/image_cropper.dart';

class ImagePickerRepositoryImpl implements ImagePickerRepository {
  final ImagePickerDatasource imagePickerDatasource;
  ImagePickerRepositoryImpl({
    required this.imagePickerDatasource,
  });

  @override
  Future<Either<NotificationAlert, File>> getImageFromCamera() async {
    try {
      final image = await imagePickerDatasource.getImageFromCamera();
      if (image == null) {
        return Left(mapImagePickerFailureToNotificationAlert(
          NoPhotoTakenFailure(),
        ));
      }
      return Right(File(image.path));
    } catch (e) {
      return Left(mapImagePickerFailureToNotificationAlert(
        NoPhotoTakenFailure(),
      ));
    }
  }

  @override
  Future<Either<NotificationAlert, File>> getImageFromGallery() async {
    try {
      final image = await imagePickerDatasource.getImageFromGallery();
      if (image == null) {
        return Left(mapImagePickerFailureToNotificationAlert(
          NoPhotoSelectedFailure(),
        ));
      }
      return Right(File(image.path));
    } catch (e) {
      return Left(mapImagePickerFailureToNotificationAlert(
        NoPhotoSelectedFailure(),
      ));
    }
  }

  @override
  Future<Either<NotificationAlert, File>> cropImage({
    required String sourcePath,
    required int compressQuality,
    required CropAspectRatio aspectRatio,
  }) async {
    try {
      final croppedFile = await imagePickerDatasource.cropImage(
        sourcePath: sourcePath,
        compressQuality: compressQuality,
        aspectRatio: aspectRatio,
      );
      if (croppedFile == null) {
        return Left(
          mapImagePickerFailureToNotificationAlert(PhotoNotCroppedFailure()),
        );
      }
      return Right(File(croppedFile.path));
    } catch (e) {
      return Left(
        mapImagePickerFailureToNotificationAlert(PhotoNotCroppedFailure()),
      );
    }
  }

  @override
  Future<Either<NotificationAlert, File>> convertPngToJpeg({
    required Image image,
    required String oldPath,
  }) async {
    try {
      return Right(await imagePickerDatasource.convertPngToJpeg(
        image: image,
        oldPath: oldPath,
      ));
    } catch (e) {
      return Left(FailureHelper.catchFailureToNotificationAlert(exception: e));
    }
  }

  @override
  Future<Either<NotificationAlert, Image>> fileToImage({
    required File file,
  }) async {
    try {
      final Image? img = await imagePickerDatasource.fileToImage(file: file);
      if (img == null) {
        return Left(NotificationAlert(
          title: "Fehler beim Konvertieren",
          message: "Fehler beim Konvertieren der File zu einem Bild",
        ));
      }
      return Right(img);
    } catch (e) {
      return Left(FailureHelper.catchFailureToNotificationAlert(exception: e));
    }
  }
}
