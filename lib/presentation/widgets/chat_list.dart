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
      itemBuilder: (context, index) {
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
          subtitle: const Text(
            "Letzte Nachricht",
            softWrap: true,
            overflow: TextOverflow.ellipsis,
          ),
          onTap: () {
            AutoRouter.of(context).push(
              ChatPageWrapperRoute(
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
