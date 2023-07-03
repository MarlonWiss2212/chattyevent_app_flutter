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
      filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
      child: Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.all(20),
        child: Padding(
          padding: const EdgeInsets.all(12),
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
                const SizedBox(height: 20),
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      InkWell(
                        borderRadius: BorderRadius.circular(8),
                        onTap: () => BlocProvider.of<AddMessageCubit>(c)
                            .setFileFromCamera(),
                        child: Ink(
                          padding: const EdgeInsets.all(10),
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
                      ),
                      InkWell(
                        borderRadius: BorderRadius.circular(8),
                        onTap: () => BlocProvider.of<AddMessageCubit>(c)
                            .setFileFromGallery(),
                        child: Ink(
                          padding: const EdgeInsets.all(10),
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
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
