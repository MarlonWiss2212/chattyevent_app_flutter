import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app_flutter/application/bloc/private_event/current_private_event_cubit.dart';

class DeclineInviteIconButton extends StatelessWidget {
  final String userId;
  const DeclineInviteIconButton({
    super.key,
    required this.userId,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(
        Icons.close,
        color: Colors.red,
      ),
      onPressed: () {
        BlocProvider.of<CurrentPrivateEventCubit>(context)
            .updatePrivateEventUser(
          status: "rejected",
          userId: userId,
        );
      },
    );
  }
}
