import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:social_media_app_flutter/application/bloc/auth/auth_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/chat/current_chat_cubit.dart';
import 'package:social_media_app_flutter/presentation/widgets/dialog/buttons/ok_button.dart';

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
        await showPlatformDialog(
          context: context,
          builder: (c) {
            return PlatformAlertDialog(
              title: const Text("Gruppenchat verlassen"),
              content: const Text(
                "Möchtest du den Gruppenchat wirklich verlassen",
              ),
              actions: [
                PlatformTextButton(
                  onPressed: () async {
                    await BlocProvider.of<CurrentChatCubit>(context)
                        .deleteUserFromChat(
                      userId: BlocProvider.of<AuthCubit>(context)
                          .state
                          .currentUser
                          .id,
                    );
                    Navigator.of(c).pop();
                  },
                  child: const Text("Ja"),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
