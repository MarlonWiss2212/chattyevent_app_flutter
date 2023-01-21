import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:meta/meta.dart';
import 'package:social_media_app_flutter/domain/failures/image_picker_failures.dart';
import 'package:social_media_app_flutter/domain/usecases/image_picker_usecases.dart';

part 'image_state.dart';

class ImageCubit extends Cubit<ImageState> {
  final ImagePickerUseCases imagePickerUseCases;
  ImageCubit({required this.imagePickerUseCases}) : super(ImageInitial());

  Future getImageFromCamera({CropAspectRatio? cropAspectRatio}) async {
    emit(ImageLoading());

    final imagePickerErrorOrImage = await imagePickerUseCases
        .getImageFromCameraWithPermissions(cropAspectRatio: cropAspectRatio);

    imagePickerErrorOrImage.fold(
      (failure) {
        final error = mapImagePickerFailureToErrorWithTitleAndMessage(failure);
        emit(ImageError(message: error.message, title: error.title));
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
        emit(ImageError(message: error.message, title: error.title));
      },
      (image) {
        emit(ImageLoaded(image: image));
      },
    );
  }
}
