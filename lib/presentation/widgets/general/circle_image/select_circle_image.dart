import 'dart:io';
import 'package:flutter/material.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/bottom_sheet/image_picker_list.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/circle_image/cirlce_image.dart';

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
    return CircleImage(
      image: image,
      onTap: () async {
        await showModalBottomSheet(
          context: context,
          builder: (context) {
            return ImagePickerList(
              ratioX: 1,
              ratioY: 1,
              imageChanged: (newImage) {
                imageChanged(newImage);
                Navigator.of(context).pop();
              },
            );
          },
        );
      },
      icon: const Icon(Icons.add),
    );
  }
}
