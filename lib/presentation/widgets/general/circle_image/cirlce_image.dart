import 'dart:io';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CircleImage extends StatelessWidget {
  final File? image;
  final String? heroTag;
  final String? imageLink;
  final double? height;
  final double? width;
  final Icon? icon;
  final void Function()? onTap;
  const CircleImage({
    this.onTap,
    super.key,
    this.image,
    this.icon,
    this.imageLink,
    this.heroTag,
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final height = this.height ?? min(120, size.width / 1.5);
    final width = this.width ?? min(120, size.width / 1.5);

    return image != null || imageLink != null
        ? SizedBox(
            height: height,
            width: width,
            child: InkWell(
              onTap: onTap,
              customBorder: const CircleBorder(),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(width / 2),
                child: Hero(
                  tag: heroTag ?? "",
                  child: image != null
                      ? Image.file(image!, fit: BoxFit.cover)
                      : CachedNetworkImage(
                          imageUrl: imageLink!,
                          fit: BoxFit.cover,
                        ),
                ),
              ),
            ),
          )
        : Ink(
            height: height,
            width: width,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Theme.of(context).colorScheme.surface,
            ),
            child: InkWell(
              onTap: onTap,
              customBorder: const CircleBorder(),
              child: Center(
                child: icon,
              ),
            ),
          );
  }
}
