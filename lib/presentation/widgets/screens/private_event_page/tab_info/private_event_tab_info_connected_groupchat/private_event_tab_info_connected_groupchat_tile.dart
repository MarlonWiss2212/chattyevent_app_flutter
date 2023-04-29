import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app_flutter/application/bloc/current_groupchat/current_chat_cubit.dart';
import 'package:social_media_app_flutter/presentation/router/router.gr.dart';

class PrivateEventTabInfogroupchatToTile extends StatelessWidget {
  final CurrentChatState chatState;
  const PrivateEventTabInfogroupchatToTile({
    super.key,
    required this.chatState,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: chatState.currentChat.profileImageLink != null
            ? NetworkImage(
                chatState.currentChat.profileImageLink!,
              )
            : null,
        backgroundColor: chatState.currentChat.profileImageLink == null
            ? Theme.of(context).colorScheme.secondaryContainer
            : null,
      ),
      title: chatState.currentChat.title != null
          ? Hero(
              tag: "${chatState.currentChat.id} title",
              child: Text(
                chatState.currentChat.title!,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            )
          : Text(
              "Kein Titel",
              style: Theme.of(context).textTheme.titleMedium,
            ),
      subtitle: const Text(
        "Verbundener Gruppenchat",
        softWrap: true,
        overflow: TextOverflow.ellipsis,
      ),
      onTap: () {
        AutoRouter.of(context).root.push(
              ChatPageWrapperRoute(
                chatStateToSet: chatState,
                groupchatId: chatState.currentChat.id,
              ),
            );
      },
    );
  }
}
