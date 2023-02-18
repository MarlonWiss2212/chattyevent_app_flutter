import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app_flutter/domain/entities/groupchat/groupchat_entity.dart';
import 'package:social_media_app_flutter/presentation/router/router.gr.dart';

class ChatList extends StatelessWidget {
  final List<GroupchatEntity> chats;
  const ChatList({super.key, required this.chats});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemBuilder: (context, index) {
        final message =
            chats[index].messages != null && chats[index].messages!.isNotEmpty
                ? chats[index].messages!.last
                : null;
        return ListTile(
          leading: CircleAvatar(
            backgroundImage: chats[index].profileImageLink != null
                ? NetworkImage(chats[index].profileImageLink!)
                : null,
            backgroundColor: chats[index].profileImageLink == null
                ? Theme.of(context).colorScheme.secondaryContainer
                : null,
          ),
          title: Hero(
            tag: "${chats[index].id} title",
            child: Text(
              chats[index].title ?? "Kein Titel",
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          subtitle: message != null
              ? Text(
                  "${message.createdBy}: ${message.message}",
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                )
              : const Text(
                  "Keine Nachricht",
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                ),
          onTap: () {
            AutoRouter.of(context).push(
              ChatPageWrapperRoute(
                chatToSet: chats[index],
                loadChatFromApiToo: true,
                groupchatId: chats[index].id,
              ),
            );
          },
        );
      },
      itemCount: chats.length,
    );
  }
}
