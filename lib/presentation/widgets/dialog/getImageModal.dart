import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_media_app_flutter/domain/usecases/image_picker_usecases.dart';
import 'package:social_media_app_flutter/presentation/widgets/dialog/buttons/ok_button.dart';
import 'package:social_media_app_flutter/presentation/widgets/divider.dart';
import './../../../injection.dart' as di;

class GetImageModal extends StatelessWidget {
  final void Function(XFile newImage) imageChanged;
  const GetImageModal({super.key, required this.imageChanged});

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
                          imageChanged(xfile);
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
                          imageChanged(xfile);
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
