import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app_flutter/application/bloc/private_event/private_event_bloc.dart';

class NeutralInviteIconButton extends StatelessWidget {
  final String privateEventId;
  const NeutralInviteIconButton({super.key, required this.privateEventId});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(
        Icons.remove,
        color: Colors.grey,
      ),
      onPressed: () {
        BlocProvider.of<PrivateEventBloc>(context).add(
          UpdateMeInPrivateEventNoInformationOnWillBeThereEvent(
            privateEventId: privateEventId,
          ),
        );
      },
    );
  }
}
