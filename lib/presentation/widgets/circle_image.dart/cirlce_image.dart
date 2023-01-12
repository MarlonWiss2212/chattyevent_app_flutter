import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';

class CircleImage extends StatelessWidget {
  final File? image;
  final Icon? icon;
  const CircleImage({super.key, this.image, this.icon});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return image != null
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
                fit: BoxFit.cover,
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
            child: Center(
              child: icon,
            ),
          );
  }
}
