import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:skeletons/skeletons.dart';
import 'package:social_media_app_flutter/application/bloc/chat/current_chat_cubit.dart';
import 'package:social_media_app_flutter/presentation/router/router.gr.dart';

class PrivateEventListGroupchat extends StatelessWidget {
  final CurrentChatState chatState;
  const PrivateEventListGroupchat({super.key, required this.chatState});

  @override
  Widget build(BuildContext context) {
    List<Widget> widgetsToReturn = [];

    if (chatState.privateEvents.isEmpty && chatState.loadingPrivateEvents) {
      widgetsToReturn.add(
        SkeletonListTile(
          padding: const EdgeInsets.all(8),
          hasSubtitle: true,
          titleStyle: const SkeletonLineStyle(width: 100, height: 22),
          subtitleStyle:
              const SkeletonLineStyle(width: double.infinity, height: 16),
          leadingStyle: const SkeletonAvatarStyle(
            shape: BoxShape.circle,
          ),
        ),
      );
    } else {
      for (final privateEvent in chatState.privateEvents) {
        widgetsToReturn.add(
          ListTile(
            leading: CircleAvatar(
              backgroundImage: privateEvent.coverImageLink != null
                  ? NetworkImage(privateEvent.coverImageLink!)
                  : null,
              backgroundColor: privateEvent.coverImageLink == null
                  ? Theme.of(context).colorScheme.secondaryContainer
                  : null,
            ),
            title: Hero(
              tag: "${privateEvent.id} title",
              child: Text(
                privateEvent.title ?? "Kein Titel",
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            subtitle: Text(
              privateEvent.eventDate != null
                  ? DateFormat.yMd().add_jm().format(privateEvent.eventDate!)
                  : "Kein Datum",
              softWrap: true,
              overflow: TextOverflow.ellipsis,
            ),
            onTap: () {
              AutoRouter.of(context).push(
                PrivateEventWrapperPageRoute(
                  loadPrivateEventFromApiToo: true,
                  privateEventToSet: privateEvent,
                  privateEventId: privateEvent.id,
                ),
              );
            },
          ),
        );
      }
    }

    return Column(
      children: [
        Text(
          "Private Events: ${widgetsToReturn.length}",
          style: Theme.of(context).textTheme.titleMedium,
        ),
        if (widgetsToReturn.isNotEmpty) ...{const SizedBox(height: 8)},
        ...widgetsToReturn
      ],
    );
  }
}
