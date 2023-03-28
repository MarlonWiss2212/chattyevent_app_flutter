import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app_flutter/application/bloc/auth/auth_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/chat/current_chat_cubit.dart';
import 'package:social_media_app_flutter/presentation/widgets/general/dialog/accept_decline_dialog.dart';

class ChatInfoPageLeaveChat extends StatelessWidget {
  const ChatInfoPageLeaveChat({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(
        Icons.logout,
        color: Colors.red,
      ),
      title: const Text(
        "Gruppenchat verlassen",
        style: TextStyle(color: Colors.red),
      ),
      onTap: () async {
        await showDialog(
          context: context,
          builder: (c) {
            return AcceptDeclineDialog(
              title: "Gruppenchat verlassen",
              message: "Möchtest du den Gruppenchat wirklich verlassen",
              onNoPress: () => Navigator.of(c).pop(),
              onYesPress: () =>
                  BlocProvider.of<CurrentChatCubit>(context).deleteUserFromChat(
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
