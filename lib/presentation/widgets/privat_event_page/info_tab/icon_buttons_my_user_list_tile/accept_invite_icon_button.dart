import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app_flutter/application/bloc/private_event/private_event_bloc.dart';

class AcceptInviteIconButton extends StatelessWidget {
  final String privateEventId;
  const AcceptInviteIconButton({super.key, required this.privateEventId});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(
        Icons.done,
        color: Colors.green,
      ),
      onPressed: () {
        BlocProvider.of<PrivateEventBloc>(context).add(
          UpdateMeInPrivateEventWillBeThereEvent(
            privateEventId: privateEventId,
          ),
        );
      },
    );
  }
}
