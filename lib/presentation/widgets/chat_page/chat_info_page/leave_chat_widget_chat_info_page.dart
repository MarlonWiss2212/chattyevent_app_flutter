import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app_flutter/application/bloc/chat/current_chat_cubit.dart';
import 'package:social_media_app_flutter/core/dto/groupchat/create_groupchat_left_user_dto.dart';

class LeaveChatWidgetChatInfoPage extends StatelessWidget {
  final CurrentChatState chatState;
  final String currentUserId;
  const LeaveChatWidgetChatInfoPage({
    super.key,
    required this.chatState,
    required this.currentUserId,
  });

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
          createGroupchatLeftUserDto: CreateGroupchatLeftUserDto(
            userId: currentUserId,
            leftGroupchatTo: chatState.currentChat.id,
          ),
        );
      },
    );
  }
}
