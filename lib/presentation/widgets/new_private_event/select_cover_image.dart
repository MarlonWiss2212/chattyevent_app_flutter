import 'dart:io';
import 'package:flutter/material.dart';
import 'package:social_media_app_flutter/presentation/widgets/bottom_sheet/image_picker_list.dart';

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
          ? Container(
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
          : Card(
              child: SizedBox(
                width: size.width,
                height: (size.width / 4 * 3) - 16,
                child: const Icon(Icons.add),
              ),
            ),
    );
  }
}
