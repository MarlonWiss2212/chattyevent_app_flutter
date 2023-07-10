import 'dart:io';
import 'package:flutter/material.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/bottom_sheet/image_picker_list.dart';

class SelectCoverImage extends StatelessWidget {
  final void Function(File newImage) imageChanged;
  final File? image;
  const SelectCoverImage({
    super.key,
    required this.imageChanged,
    this.image,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return InkWell(
      borderRadius: const BorderRadius.all(
        Radius.circular(8.0),
      ),
      onTap: () async {
        await showModalBottomSheet(
          context: context,
          builder: (
            context,
          ) {
            return ImagePickerList(
              ratioX: 4,
              ratioY: 3,
              imageChanged: (newImage) {
                imageChanged(newImage);
                Navigator.of(context).pop();
              },
            );
          },
        );
      },
      child: image != null
          ? Ink(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.file(
                  image!,
                  fit: BoxFit.fitWidth,
                ),
              ),
            )
          : Ink(
              width: size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
              ),
              height: (size.width / 4 * 3) - 16,
              child: const Icon(Icons.add),
            ),
    );
  }
}
