import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:social_media_app_flutter/presentation/widgets/circle_image.dart/cirlce_image.dart';
import 'package:social_media_app_flutter/presentation/widgets/dialog/getImageModal.dart';

class SelectCircleImage extends StatelessWidget {
  final void Function(File newImage) imageChanged;
  final File? image;
  const SelectCircleImage({
    super.key,
    required this.imageChanged,
    this.image,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return InkWell(
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
                imageChanged(
                  File(newImage.path),
                );
                Navigator.of(context).pop();
              },
            );
          },
        );
      },
      child: CircleImage(
        image: image,
        icon: const Icon(Icons.add),
      ),
    );
  }
}
