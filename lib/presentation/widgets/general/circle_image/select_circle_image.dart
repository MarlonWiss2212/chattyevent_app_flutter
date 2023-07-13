import 'dart:io';
import 'package:flutter/material.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/dialog/image_picker_dialog.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/circle_image/cirlce_image.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';

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
        await showAnimatedDialog(
          curve: Curves.fastOutSlowIn,
          animationType: DialogTransitionType.slideFromBottomFade,
          context: context,
          builder: (context) {
            return ImagePickerDialog(
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
