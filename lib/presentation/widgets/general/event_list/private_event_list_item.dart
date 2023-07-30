import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:chattyevent_app_flutter/application/bloc/current_event/current_event_cubit.dart';
import 'package:chattyevent_app_flutter/presentation/router/router.gr.dart';

class PrivateEventListItem extends StatelessWidget {
  final CurrentEventState privateEventState;
  const PrivateEventListItem({super.key, required this.privateEventState});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: privateEventState.event.coverImageLink != null
            ? NetworkImage(privateEventState.event.coverImageLink!)
            : null,
        backgroundColor: privateEventState.event.coverImageLink == null
            ? Theme.of(context).colorScheme.surface
            : null,
      ),
      title: Hero(
        tag: "${privateEventState.event.id} title",
        child: Text(
          privateEventState.event.title ?? "",
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      subtitle: Text(
        DateFormat.yMd().add_jm().format(
              privateEventState.event.eventDate,
            ),
        softWrap: true,
        overflow: TextOverflow.ellipsis,
      ),
      onTap: () {
        AutoRouter.of(context).push(
          EventWrapperRoute(
            eventStateToSet: privateEventState,
            eventId: privateEventState.event.id,
          ),
        );
      },
    );
  }
}
