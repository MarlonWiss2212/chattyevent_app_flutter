import 'dart:io';
import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:dartz/dartz.dart';
import 'package:image/image.dart';
import 'package:image_cropper/image_cropper.dart';

abstract class ImagePickerRepository {
  Future<Either<NotificationAlert, File>> getImageFromGallery();
  Future<Either<NotificationAlert, File>> getImageFromCamera();
  Future<Either<NotificationAlert, File>> cropImage({
    required String sourcePath,
    required int compressQuality,
    required CropAspectRatio aspectRatio,
  });
  Future<Either<NotificationAlert, File>> convertPngToJpeg({
    required Image image,
    required String oldPath,
  });
  Future<Either<NotificationAlert, Image>> fileToImage({
    required File file,
  });
}
