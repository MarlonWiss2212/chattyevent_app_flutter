import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:social_media_app_flutter/application/bloc/image/image_cubit.dart';
import 'package:social_media_app_flutter/domain/usecases/image_picker_usecases.dart';
import 'package:social_media_app_flutter/presentation/widgets/dialog/buttons/ok_button.dart';
import './../../../injection.dart' as di;

class GetImageModal extends StatelessWidget {
  final void Function(File newImage) imageChanged;
  final double ratioX;
  final double ratioY;
  const GetImageModal({
    super.key,
    required this.imageChanged,
    required this.ratioX,
    required this.ratioY,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<ImageCubit, ImageState>(
      listener: (context, state) async {
        if (state is ImageLoaded) {
          imageChanged(state.image);
        } else if (state is ImageError) {
          return await showPlatformDialog(
            context: context,
            builder: (context) {
              return PlatformAlertDialog(
                title: Text(state.title),
                content: Text(state.message),
                actions: const [OKButton()],
              );
            },
          );
        }
      },
      child: Dialog(
        child: Container(
          padding: const EdgeInsets.all(8),
          height: 200,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        borderRadius: BorderRadius.circular(12),
                        onTap: () {
                          BlocProvider.of<ImageCubit>(context)
                              .getImageFromCamera(
                            cropAspectRatio: CropAspectRatio(
                              ratioX: ratioX,
                              ratioY: ratioY,
                            ),
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
                          BlocProvider.of<ImageCubit>(context)
                              .getImageFromGallery(
                            cropAspectRatio: CropAspectRatio(
                              ratioX: ratioX,
                              ratioY: ratioY,
                            ),
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
              const SizedBox(height: 8),
              const OKButton(
                width: double.infinity,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
