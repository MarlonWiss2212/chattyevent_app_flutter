import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:chattyevent_app_flutter/application/bloc/current_event/current_event_cubit.dart';
import 'package:chattyevent_app_flutter/presentation/router/router.gr.dart';

class EventListItem extends StatelessWidget {
  final CurrentEventState eventState;
  const EventListItem({super.key, required this.eventState});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: eventState.event.coverImageLink != null
            ? CachedNetworkImageProvider(
                eventState.event.coverImageLink!,
                cacheKey: eventState.event.coverImageLink!.split("?")[0],
              )
            : null,
        backgroundColor: eventState.event.coverImageLink == null
            ? Theme.of(context).colorScheme.surface
            : null,
      ),
      title: Hero(
        tag: "${eventState.event.id} title",
        child: Text(
          eventState.event.title ?? "",
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      subtitle: Text(
        DateFormat.yMd().add_jm().format(
              eventState.event.eventDate,
            ),
        softWrap: true,
        overflow: TextOverflow.ellipsis,
      ),
      onTap: () {
        AutoRouter.of(context).push(
          EventWrapperRoute(
            eventStateToSet: eventState,
            eventId: eventState.event.id,
          ),
        );
      },
    );
  }
}
