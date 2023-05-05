import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:meta/meta.dart';
import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:chattyevent_app_flutter/domain/usecases/image_picker_usecases.dart';

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
      (alert) => notificationCubit.newAlert(notificationAlert: alert),
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
      (alert) => notificationCubit.newAlert(notificationAlert: alert),
      (image) {
        emit(ImageLoaded(image: image));
      },
    );
  }
}
