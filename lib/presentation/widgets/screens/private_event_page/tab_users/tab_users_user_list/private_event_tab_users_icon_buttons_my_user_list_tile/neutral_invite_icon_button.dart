import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app_flutter/application/bloc/current_private_event/current_private_event_cubit.dart';

class NeutralInviteIconButton extends StatelessWidget {
  final String userId;
  const NeutralInviteIconButton({
    super.key,
    required this.userId,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(
        Icons.remove,
        color: Colors.grey,
      ),
      onPressed: () {
        BlocProvider.of<CurrentPrivateEventCubit>(context)
            .updatePrivateEventUser(
          status: "INVITED",
          userId: userId,
        );
      },
    );
  }
}
