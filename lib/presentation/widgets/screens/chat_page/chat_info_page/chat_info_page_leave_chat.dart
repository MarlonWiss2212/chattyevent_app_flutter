import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:social_media_app_flutter/application/bloc/auth/auth_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/chat/current_chat_cubit.dart';

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
      onTap: () {
        BlocProvider.of<CurrentChatCubit>(context).deleteUserFromChatEvent(
          userId: BlocProvider.of<AuthCubit>(context).state.user?.uid ?? "",
        );
      },
    );
  }
}
