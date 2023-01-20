import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app_flutter/application/bloc/private_event/edit_private_event_cubit.dart';

class DeclineInviteIconButton extends StatelessWidget {
  final String privateEventId;
  const DeclineInviteIconButton({super.key, required this.privateEventId});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(
        Icons.close,
        color: Colors.red,
      ),
      onPressed: () {
        BlocProvider.of<EditPrivateEventCubit>(context)
            .updateMeInPrivateEventWillNotBeThere(
          privateEventId: privateEventId,
        );
      },
    );
  }
}
