import 'package:chattyevent_app_flutter/core/enums/event/event_user/event_user_status_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chattyevent_app_flutter/application/bloc/current_event/current_event_cubit.dart';

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
        BlocProvider.of<CurrentEventCubit>(context).updateEventUser(
          status: EventUserStatusEnum.invited,
          userId: userId,
        );
      },
    );
  }
}
