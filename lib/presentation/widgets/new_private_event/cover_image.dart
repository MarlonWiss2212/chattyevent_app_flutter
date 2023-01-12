import 'dart:io';

import 'package:flutter/material.dart';
import 'package:social_media_app_flutter/presentation/widgets/dialog/getImageModal.dart';

class CoverImage extends StatelessWidget {
  final void Function(File newImage) imageChanged;
  final File? image;
  const CoverImage({
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
        await showGeneralDialog(
          context: context,
          pageBuilder: (
            context,
            animation,
            secondaryAnimation,
          ) {
            return GetImageModal(
              imageChanged: (newImage) {
                imageChanged(File(newImage.path));
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
                height: 200,
                width: size.width,
                child: const Icon(Icons.add),
              ),
            ),
    );
  }
}
