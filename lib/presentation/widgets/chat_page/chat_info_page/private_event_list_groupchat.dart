import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:skeletons/skeletons.dart';
import 'package:social_media_app_flutter/application/bloc/chat/current_chat_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/private_event/private_event_cubit.dart';
import 'package:social_media_app_flutter/domain/entities/private_event/private_event_entity.dart';
import 'package:social_media_app_flutter/presentation/router/router.gr.dart';

class PrivateEventListGroupchat extends StatelessWidget {
  final CurrentChatState chatState;
  const PrivateEventListGroupchat({super.key, required this.chatState});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PrivateEventCubit, PrivateEventState>(
      //TODO: save the events in an own store for the current groupchat private events cubit like with the current groupchat in the currentPrivateEventGroupchatStore
      builder: (context, state) {
        List<Widget> widgetsToReturn = [];
        List<PrivateEventEntity> filteredEvents = state.privateEvents
            .where(
              (element) =>
                  element.connectedGroupchat == chatState.currentChat.id,
            )
            .toList();

        if (filteredEvents.isEmpty && state is PrivateEventLoading) {
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
          for (final event in filteredEvents) {
            widgetsToReturn.add(
              ListTile(
                leading: CircleAvatar(
                  backgroundImage: event.coverImageLink != null
                      ? NetworkImage(event.coverImageLink!)
                      : null,
                  backgroundColor: event.coverImageLink == null
                      ? Theme.of(context).colorScheme.secondaryContainer
                      : null,
                ),
                title: Hero(
                  tag: "${event.id} title",
                  child: Text(
                    event.title ?? "Kein Titel",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                subtitle: Text(
                  event.eventDate != null
                      ? DateFormat.yMd().add_jm().format(event.eventDate!)
                      : "Kein Datum",
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                ),
                onTap: () {
                  AutoRouter.of(context).push(
                    PrivateEventWrapperPageRoute(
                      loadPrivateEventFromApiToo: true,
                      privateEventToSet: event,
                      privateEventId: event.id,
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
      },
    );
  }
}
