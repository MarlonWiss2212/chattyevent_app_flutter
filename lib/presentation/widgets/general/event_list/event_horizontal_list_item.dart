import 'package:chattyevent_app_flutter/core/enums/private_event/private_event_status_enum.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:chattyevent_app_flutter/domain/entities/private_event/private_event_entity.dart';

class EventHorizontalListItem extends StatelessWidget {
  final PrivateEventEntity privateEvent;
  final Function? onLongPress;
  final Function? onPress;
  final double height;
  final double width;

  const EventHorizontalListItem({
    super.key,
    required this.privateEvent,
    this.onLongPress,
    this.onPress,
    required this.height,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: const BorderRadius.all(Radius.circular(8.0)),
      onLongPress: onLongPress == null ? null : () => onLongPress!(),
      onTap: onPress == null ? null : () => onPress!(),
      child: Ink(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Theme.of(context).colorScheme.surface,
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            if (privateEvent.coverImageLink != null) ...{
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Hero(
                  tag: "${privateEvent.id} coverImage",
                  child: Image.network(
                    privateEvent.coverImageLink!,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            },
            Container(
              height: height,
              width: width,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0x00000000),
                    Color(0x00000000),
                    Color(0xCC000000),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(children: [
                    Container(
                      width: 15,
                      height: 15,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: privateEvent.status ==
                                PrivateEventStatusEnum.takesplace
                            ? Colors.green
                            : privateEvent.status ==
                                    PrivateEventStatusEnum.undecided
                                ? Colors.red
                                : privateEvent.status ==
                                        PrivateEventStatusEnum.undecided
                                    ? Colors.grey
                                    : null,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Hero(
                      tag: "${privateEvent.id} title",
                      child: Text(
                        privateEvent.title ?? "Kein Titel",
                        style: Theme.of(context).textTheme.titleLarge?.apply(
                              color: Colors.white,
                            ),
                      ),
                    ),
                  ]),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      DateFormat.yMd().add_jm().format(privateEvent.eventDate),
                      style: Theme.of(context).textTheme.bodySmall?.apply(
                            color: Colors.white,
                          ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
