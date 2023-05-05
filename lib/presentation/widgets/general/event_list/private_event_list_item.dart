import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:chattyevent_app_flutter/application/bloc/current_private_event/current_private_event_cubit.dart';
import 'package:chattyevent_app_flutter/presentation/router/router.gr.dart';

class PrivateEventListItem extends StatelessWidget {
  final CurrentPrivateEventState privateEventState;
  const PrivateEventListItem({super.key, required this.privateEventState});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: privateEventState.privateEvent.coverImageLink != null
            ? NetworkImage(privateEventState.privateEvent.coverImageLink!)
            : null,
        backgroundColor: privateEventState.privateEvent.coverImageLink == null
            ? Theme.of(context).colorScheme.secondaryContainer
            : null,
      ),
      title: Hero(
        tag: "${privateEventState.privateEvent.id} title",
        child: Text(
          privateEventState.privateEvent.title ?? "",
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      subtitle: Text(
        DateFormat.yMd().add_jm().format(
              privateEventState.privateEvent.eventDate,
            ),
        softWrap: true,
        overflow: TextOverflow.ellipsis,
      ),
      onTap: () {
        AutoRouter.of(context).push(
          PrivateEventWrapperPageRoute(
            privateEventStateToSet: privateEventState,
            privateEventId: privateEventState.privateEvent.id,
          ),
        );
      },
    );
    ;
  }
}
