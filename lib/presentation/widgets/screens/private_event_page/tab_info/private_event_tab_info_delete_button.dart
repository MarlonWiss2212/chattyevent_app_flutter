import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chattyevent_app_flutter/application/bloc/current_event/current_event_cubit.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/dialog/accept_decline_dialog.dart';

class PrivateEventTabInfoDeleteButton extends StatelessWidget {
  const PrivateEventTabInfoDeleteButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrentEventCubit, CurrentEventState>(
      builder: (context, state) {
        if (state.getCurrentEventUser()?.id == state.event.createdBy) {
          return IconButton(
            onPressed: () async {
              await showDialog(
                context: context,
                builder: (c) {
                  return AcceptDeclineDialog(
                    title: "Privates Event löschen",
                    message: "Möchtest du das Private Event wirklich löschen",
                    onNoPress: () => Navigator.of(c).pop(),
                    onYesPress: () =>
                        BlocProvider.of<CurrentEventCubit>(context)
                            .deleteCurrentEventViaApi(),
                  );
                },
              );
            },
            icon: const Icon(
              Icons.delete,
            ),
          );
        }
        return const SizedBox();
      },
    );
  }
}
