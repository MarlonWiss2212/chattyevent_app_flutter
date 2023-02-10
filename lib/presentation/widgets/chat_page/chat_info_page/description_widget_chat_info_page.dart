import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';
import 'package:social_media_app_flutter/application/bloc/chat/current_chat_cubit.dart';

class DescriptionChatInfoPage extends StatelessWidget {
  final CurrentChatState chatState;
  const DescriptionChatInfoPage({
    super.key,
    required this.chatState,
  });

  @override
  Widget build(BuildContext context) {
    if (chatState.currentChat.description == null && chatState.loadingChat) {
      return const SkeletonLine();
    } else {
      return Text(
        chatState.currentChat.description != null &&
                chatState.currentChat.description!.isNotEmpty
            ? chatState.currentChat.description!
            : "Keine Beschreibung",
        style: Theme.of(context).textTheme.titleMedium,
      );
    }
  }
}
