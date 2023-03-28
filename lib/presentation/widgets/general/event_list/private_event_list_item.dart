import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:social_media_app_flutter/domain/entities/private_event/private_event_entity.dart';
import 'package:social_media_app_flutter/presentation/router/router.gr.dart';

class PrivateEventListItem extends StatelessWidget {
  final PrivateEventEntity privateEvent;
  const PrivateEventListItem({
    super.key,
    required this.privateEvent,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
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
    );
    ;
  }
}
