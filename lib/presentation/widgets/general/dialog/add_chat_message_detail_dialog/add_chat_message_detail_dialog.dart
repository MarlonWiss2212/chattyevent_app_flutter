import 'dart:ui';
import 'package:chattyevent_app_flutter/application/bloc/add_message/add_message_cubit.dart';
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
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
      child: Dialog(
        backgroundColor: Colors.transparent,
        child: Align(
          alignment: Alignment.topLeft,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(Ionicons.close),
              ),
              const SizedBox(height: 12),
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(height: 12),
                    GestureDetector(
                      onTap: () => BlocProvider.of<AddMessageCubit>(c)
                          .setFileFromCamera(),
                      child: Row(
                        children: [
                          const Icon(Ionicons.camera, size: 32),
                          const SizedBox(width: 32),
                          Text(
                            "Kamera",
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    GestureDetector(
                      onTap: () => BlocProvider.of<AddMessageCubit>(c)
                          .setFileFromGallery(),
                      child: Row(
                        children: [
                          const Icon(Ionicons.image, size: 32),
                          const SizedBox(width: 32),
                          Text(
                            "Gallerie",
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
