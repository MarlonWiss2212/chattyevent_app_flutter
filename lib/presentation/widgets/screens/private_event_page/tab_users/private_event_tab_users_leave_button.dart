import 'package:chattyevent_app_flutter/application/bloc/current_private_event/current_private_event_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chattyevent_app_flutter/application/bloc/auth/auth_cubit.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/dialog/accept_decline_dialog.dart';

class PrivateEventTabUsersLeaveButton extends StatelessWidget {
  const PrivateEventTabUsersLeaveButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(
        Icons.logout,
        color: Colors.red,
      ),
      title: const Text(
        "Privates Event verlassen",
        style: TextStyle(color: Colors.red),
      ),
      onTap: () async {
        await showDialog(
          context: context,
          builder: (c) {
            return AcceptDeclineDialog(
              title: "Privates Event verlassen",
              message: "Möchtest du das Private Event wirklich verlassen",
              onNoPress: () => Navigator.of(c).pop(),
              onYesPress: () =>
                  BlocProvider.of<CurrentPrivateEventCubit>(context)
                      .deleteUserFromPrivateEventViaApi(
                userId:
                    BlocProvider.of<AuthCubit>(context).state.currentUser.id,
              ),
            );
          },
        );
      },
    );
  }
}
