import 'package:chattyevent_app_flutter/application/bloc/add_message/add_message_cubit.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/dialog/blur_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';

class AddChatMessageDetailDialog extends StatelessWidget {
  final BuildContext c;
  const AddChatMessageDetailDialog({
    super.key,
    required this.c,
  });

  @override
  Widget build(BuildContext context) {
    return BlurDialog(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          InkWell(
            borderRadius: BorderRadius.circular(8),
            onTap: () {
              BlocProvider.of<AddMessageCubit>(c).setFileFromCamera();
              Navigator.of(context).pop();
            },
            child: Ink(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  const Icon(CupertinoIcons.camera_fill, size: 32),
                  const SizedBox(width: 32),
                  Text(
                    "Kamera",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
            ),
          ),
          InkWell(
            borderRadius: BorderRadius.circular(8),
            onTap: () {
              BlocProvider.of<AddMessageCubit>(c).setFileFromGallery();
              Navigator.of(context).pop();
            },
            child: Ink(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  const Icon(CupertinoIcons.photo_fill, size: 32),
                  const SizedBox(width: 32),
                  Text(
                    "Gallerie",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
            ),
          ),
          InkWell(
            borderRadius: BorderRadius.circular(8),
            onTap: () {
              BlocProvider.of<AddMessageCubit>(c).setCurrentLocation();
              Navigator.of(context).pop();
            },
            child: Ink(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  const Icon(Ionicons.location, size: 32),
                  const SizedBox(width: 32),
                  Text(
                    "Dein Standort",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
