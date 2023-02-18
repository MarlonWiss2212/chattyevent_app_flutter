import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';
import 'package:social_media_app_flutter/application/bloc/chat/current_chat_cubit.dart';
import 'package:social_media_app_flutter/presentation/widgets/message_list.dart';

class MessageArea extends StatelessWidget {
  final CurrentChatState chatState;
  const MessageArea({super.key, required this.chatState});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Builder(builder: (context) {
        final messagesAreNotLoaded = chatState.currentChat.messages == null &&
                chatState.loadingMessages == false ||
            chatState.currentChat.messages != null &&
                chatState.currentChat.messages!.isEmpty &&
                chatState.loadingMessages == false;

        const emptyReturn = Center(child: Text("Keine Nachrichten"));

        if (messagesAreNotLoaded) {
          return emptyReturn;
        }

        final loadingMessages = chatState.currentChat.messages!.isEmpty &&
                chatState.loadingMessages ||
            chatState.currentChat.messages == null && chatState.loadingMessages;

        if (loadingMessages) {
          return SkeletonListView(
            itemBuilder: (p0, p1) {
              return SkeletonListTile(
                hasSubtitle: true,
                hasLeading: false,
                titleStyle: const SkeletonLineStyle(
                  width: double.infinity,
                  height: 22,
                ),
                subtitleStyle: const SkeletonLineStyle(
                  width: double.infinity,
                  height: 16,
                ),
              );
            },
          );
        }

        return MessageList(
          groupchatTo: chatState.currentChat.id,
          messages: chatState.currentChat.messages!,
        );
      }),
    );
  }
}
