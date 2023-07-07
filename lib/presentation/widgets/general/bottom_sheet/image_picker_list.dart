import 'dart:io';
import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:chattyevent_app_flutter/core/utils/injection.dart';
import 'package:chattyevent_app_flutter/domain/usecases/image_picker_usecases.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:ionicons/ionicons.dart';

class ImagePickerList extends StatelessWidget {
  final void Function(File newImage) imageChanged;
  final double? ratioX;
  final double? ratioY;
  const ImagePickerList({
    super.key,
    required this.imageChanged,
    this.ratioX,
    this.ratioY,
  });

  @override
  Widget build(BuildContext context) {
    CropAspectRatio? cropAspectRatio;
    if (ratioX != null && ratioY != null) {
      cropAspectRatio = CropAspectRatio(
        ratioX: ratioX!,
        ratioY: ratioY!,
      );
    }

    return Column(
      children: [
        ListTile(
          leading: const Icon(Ionicons.camera),
          title: const Text("Kamera"),
          onTap: () async {
            final image = await serviceLocator<ImagePickerUseCases>()
                .getImageFromCameraWithPermissions(
              cropAspectRatio: cropAspectRatio,
            );
            image.fold(
                (alert) => serviceLocator<NotificationCubit>().newAlert(
                      notificationAlert: alert,
                    ),
                imageChanged);
          },
        ),
        ListTile(
          leading: const Icon(Ionicons.image),
          title: const Text("Gallerie"),
          onTap: () async {
            final image = await serviceLocator<ImagePickerUseCases>()
                .getImageFromPhotosWithPermissions(
                    cropAspectRatio: cropAspectRatio);
            image.fold(
              (alert) => serviceLocator<NotificationCubit>().newAlert(
                notificationAlert: alert,
              ),
              imageChanged,
            );
          },
        ),
      ],
    );
  }
}
