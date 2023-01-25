import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app_flutter/application/bloc/chat/chat_cubit.dart';
import 'package:social_media_app_flutter/domain/entities/groupchat/groupchat_entity.dart';
import 'package:social_media_app_flutter/domain/entities/private_event_entity.dart';
import 'package:social_media_app_flutter/presentation/router/router.gr.dart';

class ConnectedGroupchatTilePrivateEvent extends StatelessWidget {
  final PrivateEventEntity privateEvent;
  const ConnectedGroupchatTilePrivateEvent({
    super.key,
    required this.privateEvent,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatCubit, ChatState>(builder: (context, state) {
      GroupchatEntity? foundGroupchat;

      if (state is ChatLoaded && privateEvent.connectedGroupchat != null) {
        for (final chat in state.chats) {
          if (chat.id == privateEvent.connectedGroupchat) {
            foundGroupchat = chat;
          }
        }
      }

      return ListTile(
        leading: CircleAvatar(
          backgroundImage:
              foundGroupchat != null && foundGroupchat.profileImageLink != null
                  ? NetworkImage(
                      foundGroupchat.profileImageLink!,
                    )
                  : null,
          backgroundColor:
              foundGroupchat == null || foundGroupchat.profileImageLink == null
                  ? Theme.of(context).colorScheme.secondaryContainer
                  : null,
        ),
        title: foundGroupchat != null && foundGroupchat.title != null
            ? Hero(
                tag: "${foundGroupchat.id} title",
                child: Text(
                  foundGroupchat.title!,
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
          if (foundGroupchat != null) {
            AutoRouter.of(context).root.push(
                  ChatPageWrapperRoute(
                    groupchatId: foundGroupchat.id,
                  ),
                );
          }
        },
      );
    });
  }
}
