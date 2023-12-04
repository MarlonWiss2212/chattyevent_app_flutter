import 'dart:io';
import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:dartz/dartz.dart';
import 'package:image_cropper/image_cropper.dart';

abstract class ImagePickerRepository {
  /// Either return a [NotificationAlert] when an error occurred or
  /// returns the File from the gallery
  Future<Either<NotificationAlert, File>> getImageFromGallery();

  /// Either return a [NotificationAlert] when an error occurred or
  /// returns the File from the camera
  Future<Either<NotificationAlert, File>> getImageFromCamera();

  /// Either return a [NotificationAlert] when an error occurred or
  /// returns the cropped File
  Future<Either<NotificationAlert, File>> cropImage({
    required String sourcePath,
    required int compressQuality,
    required CropAspectRatio aspectRatio,
  });
}
