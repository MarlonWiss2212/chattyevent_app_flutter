import 'dart:io';
import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:chattyevent_app_flutter/core/utils/injection.dart';
import 'package:chattyevent_app_flutter/domain/usecases/image_picker_usecases.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/dialog/blur_dialog.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:ionicons/ionicons.dart';

class ImagePickerDialog extends StatelessWidget {
  final void Function(File newImage) imageChanged;
  final double? ratioX;
  final double? ratioY;
  const ImagePickerDialog({
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

    return BlurDialog(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          InkWell(
            borderRadius: BorderRadius.circular(8),
            onTap: () async {
              final image = await serviceLocator<ImagePickerUseCases>()
                  .getImageFromCameraWithPermissions(
                cropAspectRatio: cropAspectRatio,
              );
              image.fold(
                (alert) => serviceLocator<NotificationCubit>().newAlert(
                  notificationAlert: alert,
                ),
                imageChanged,
              );
            },
            child: Ink(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  const Icon(Ionicons.camera, size: 32),
                  const SizedBox(width: 32),
                  Text(
                    "Kamera",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
            ),
          ),
          InkWell(
            borderRadius: BorderRadius.circular(8),
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
            child: Ink(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  const Icon(Ionicons.image, size: 32),
                  const SizedBox(width: 32),
                  Text(
                    "Gallerie",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
