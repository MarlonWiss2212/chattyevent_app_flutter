import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:social_media_app_flutter/domain/usecases/image_picker_usecases.dart';
import 'package:social_media_app_flutter/presentation/widgets/dialog/buttons/ok_button.dart';
import './../../../injection.dart' as di;

class GetImageModal extends StatelessWidget {
  final void Function(File newImage) imageChanged;
  final double ratioX;
  final double ratioY;
  const GetImageModal({
    super.key,
    required this.imageChanged,
    required this.ratioX,
    required this.ratioY,
  });

  @override
  Widget build(BuildContext context) {
    final imagePickerUseCases = ImagePickerUseCases(
      imagePickerRepository: di.serviceLocator(),
    );

    return Dialog(
      child: Container(
        padding: const EdgeInsets.all(8),
        height: 200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: () async {
                        final photoStatus =
                            await imagePickerUseCases.requestCameraPermission();
                        final xfile =
                            await imagePickerUseCases.getImageFromCamera();
                        if (xfile != null) {
                          final croppedImage = await ImageCropper().cropImage(
                            sourcePath: xfile.path,
                            aspectRatio: CropAspectRatio(
                              ratioX: ratioX,
                              ratioY: ratioY,
                            ),
                          );
                          if (croppedImage != null) {
                            imageChanged(File(croppedImage.path));
                          }
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Theme.of(context).colorScheme.onBackground,
                          ),
                        ),
                        child: const Center(
                          child: Icon(Icons.camera),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: () async {
                        final photoStatus =
                            await imagePickerUseCases.requestPhotosPermission();
                        final xfile =
                            await imagePickerUseCases.getImageFromGallery();
                        if (xfile != null) {
                          final croppedImage = await ImageCropper().cropImage(
                            sourcePath: xfile.path,
                            aspectRatio: CropAspectRatio(
                              ratioX: ratioX,
                              ratioY: ratioY,
                            ),
                          );
                          if (croppedImage != null) {
                            imageChanged(File(croppedImage.path));
                          }
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Theme.of(context).colorScheme.onBackground,
                          ),
                        ),
                        child: const Center(
                          child: Icon(Icons.photo_album),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            const OKButton(
              width: double.infinity,
            ),
          ],
        ),
      ),
    );
  }
}
