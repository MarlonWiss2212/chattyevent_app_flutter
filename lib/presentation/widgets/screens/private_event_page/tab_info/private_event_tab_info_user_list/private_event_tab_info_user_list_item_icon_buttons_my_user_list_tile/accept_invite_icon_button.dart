import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app_flutter/application/bloc/private_event/current_private_event_cubit.dart';
import 'package:social_media_app_flutter/core/dto/private_event/update_private_event_user_dto.dart';

class AcceptInviteIconButton extends StatelessWidget {
  const AcceptInviteIconButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(
        Icons.done,
        color: Colors.green,
      ),
      onPressed: () {
        BlocProvider.of<CurrentPrivateEventCubit>(context)
            .updatePrivateEventUser(
          updatePrivateEventUserDto: UpdatePrivateEventUserDto(
            status: "accapted",
          ),
        );
      },
    );
  }
}