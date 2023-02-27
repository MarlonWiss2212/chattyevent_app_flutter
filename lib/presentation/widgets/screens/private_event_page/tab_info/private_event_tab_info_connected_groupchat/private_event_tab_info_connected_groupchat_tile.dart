import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app_flutter/domain/entities/groupchat/groupchat_entity.dart';
import 'package:social_media_app_flutter/presentation/router/router.gr.dart';

class PrivateEventTabInfoConnectedGroupchatTile extends StatelessWidget {
  final GroupchatEntity groupchat;
  const PrivateEventTabInfoConnectedGroupchatTile({
    super.key,
    required this.groupchat,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: groupchat.profileImageLink != null
            ? NetworkImage(
                groupchat.profileImageLink!,
              )
            : null,
        backgroundColor: groupchat.profileImageLink == null
            ? Theme.of(context).colorScheme.secondaryContainer
            : null,
      ),
      title: groupchat.title != null
          ? Hero(
              tag: "${groupchat.id} title",
              child: Text(
                groupchat.title!,
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
                chatToSet: groupchat,
                loadChatFromApiToo: true,
                groupchatId: groupchat.id,
              ),
            );
      },
    );
  }
}
