import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:social_media_app_flutter/domain/entities/private_event_entity.dart';

class EventGridListItem extends StatelessWidget {
  final PrivateEventEntity privateEvent;
  final Function? onLongPress;
  final Function? onPress;
  final double height;
  final double width;

  const EventGridListItem({
    super.key,
    required this.privateEvent,
    this.onLongPress,
    this.onPress,
    required this.height,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return InkWell(
      borderRadius: const BorderRadius.all(Radius.circular(8.0)),
      onLongPress: onLongPress == null ? null : () => onLongPress!(),
      onTap: onPress == null ? null : () => onPress!(),
      child: Ink(
        width: width,
        height: height,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Theme.of(context).colorScheme.primaryContainer,
          ),
          child: Stack(
            fit: StackFit.expand,
            children: [
              privateEvent.coverImageLink != null
                  ? Container(
                      decoration: const BoxDecoration(shape: BoxShape.circle),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Hero(
                          tag: "${privateEvent.id} coverImage",
                          child: Image.network(
                            privateEvent.coverImageLink!,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    )
                  : Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Theme.of(context).colorScheme.tertiaryContainer,
                      ),
                    ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Hero(
                      tag: "${privateEvent.id} title",
                      child: Text(
                        privateEvent.title ?? "Kein Titel",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                    Text(
                      privateEvent.eventDate != null
                          ? DateFormat.yMd()
                              .add_jm()
                              .format(privateEvent.eventDate!)
                          : "Kein Datum",
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
