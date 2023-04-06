import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:meta/meta.dart';
import 'package:social_media_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:social_media_app_flutter/core/failures/image_picker_failures.dart';
import 'package:social_media_app_flutter/domain/usecases/image_picker_usecases.dart';

part 'image_state.dart';

class ImageCubit extends Cubit<ImageState> {
  final ImagePickerUseCases imagePickerUseCases;
  final NotificationCubit notificationCubit;

  ImageCubit({
    required this.imagePickerUseCases,
    required this.notificationCubit,
  }) : super(ImageInitial());

  Future getImageFromCamera({CropAspectRatio? cropAspectRatio}) async {
    emit(ImageLoading());

    final imagePickerErrorOrImage = await imagePickerUseCases
        .getImageFromCameraWithPermissions(cropAspectRatio: cropAspectRatio);

    imagePickerErrorOrImage.fold(
      (failure) {
        final error = mapImagePickerFailureToErrorWithTitleAndMessage(failure);
        notificationCubit.newAlert(
          notificationAlert: NotificationAlert(
            title: error.title,
            message: error.message,
          ),
        );
      },
      (image) {
        emit(ImageLoaded(image: image));
      },
    );
  }

  Future getImageFromGallery({CropAspectRatio? cropAspectRatio}) async {
    emit(ImageLoading());

    final imagePickerErrorOrImage = await imagePickerUseCases
        .getImageFromPhotosWithPermissions(cropAspectRatio: cropAspectRatio);

    imagePickerErrorOrImage.fold(
      (failure) {
        final error = mapImagePickerFailureToErrorWithTitleAndMessage(failure);
        notificationCubit.newAlert(
          notificationAlert: NotificationAlert(
            title: error.title,
            message: error.message,
          ),
        );
      },
      (image) {
        emit(ImageLoaded(image: image));
      },
    );
  }
}
