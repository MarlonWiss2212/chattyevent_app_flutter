import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:social_media_app_flutter/application/bloc/image/image_cubit.dart';
import 'package:social_media_app_flutter/presentation/widgets/general/dialog/alert_dialog.dart';

class ImagePickerList extends StatelessWidget {
  final void Function(File newImage) imageChanged;
  final double? ratioX;
  final double? ratioY;
  const ImagePickerList({
    super.key,
    required this.imageChanged,
    this.ratioX,
    this.ratioY,
  });

  @override
  Widget build(BuildContext context) {
    CropAspectRatio? cropAspectRatio;
    if (ratioX != null && ratioY != null) {
      cropAspectRatio = CropAspectRatio(
        ratioX: ratioX!,
        ratioY: ratioY!,
      );
    }

    return BlocListener<ImageCubit, ImageState>(
      listener: (context, state) async {
        if (state is ImageLoaded) {
          imageChanged(state.image);
        } else if (state is ImageError) {
          return await showDialog(
            context: context,
            builder: (c) {
              return CustomAlertDialog(
                title: state.title,
                message: state.message,
                context: c,
              );
            },
          );
        }
      },
      child: Container(
        constraints: BoxConstraints(
          maxHeight: min(200, MediaQuery.of(context).size.width),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: () {
                    BlocProvider.of<ImageCubit>(context).getImageFromCamera(
                      cropAspectRatio: cropAspectRatio,
                    );
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
                  onTap: () {
                    BlocProvider.of<ImageCubit>(context).getImageFromGallery(
                      cropAspectRatio: cropAspectRatio,
                    );
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
      ),
    );
  }
}
