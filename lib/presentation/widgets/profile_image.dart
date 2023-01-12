import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:social_media_app_flutter/presentation/widgets/dialog/getImageModal.dart';

class ProfileImage extends StatelessWidget {
  final void Function(File newImage) imageChanged;
  final File? image;
  const ProfileImage({
    super.key,
    required this.imageChanged,
    this.image,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return InkWell(
      borderRadius: const BorderRadius.all(
        Radius.circular(double.infinity),
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
                imageChanged(
                  File(newImage.path),
                );
                Navigator.of(context).pop();
              },
            );
          },
        );
      },
      child: image != null
          ? Container(
              height: min(120, size.width / 1.5),
              width: min(120, size.width / 1.5),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(double.infinity),
                child: Image.file(
                  image!,
                  fit: BoxFit.fill,
                ),
              ),
            )
          : Container(
              height: min(120, size.width / 1.5),
              width: min(120, size.width / 1.5),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).colorScheme.primaryContainer,
              ),
              child: const Center(
                child: Icon(Icons.add),
              ),
            ),
    );
  }
}
