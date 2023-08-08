import 'package:cached_network_image/cached_network_image.dart';
import 'package:chattyevent_app_flutter/core/enums/event/event_status_enum.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:chattyevent_app_flutter/domain/entities/event/event_entity.dart';

class EventHorizontalListItem extends StatelessWidget {
  final EventEntity event;
  final Function()? onLongPress;
  final Function()? onPress;
  final double? height;
  final double? width;

  const EventHorizontalListItem({
    super.key,
    required this.event,
    this.onLongPress,
    this.onPress,
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: const BorderRadius.all(Radius.circular(8.0)),
      onLongPress: onLongPress,
      onTap: onPress,
      child: Ink(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Theme.of(context).colorScheme.surface,
        ),
        child: Stack(
          children: [
            if (event.coverImageLink != null) ...{
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Hero(
                  tag: "${event.id} coverImage",
                  child: CachedNetworkImage(
                    imageUrl: event.coverImageLink!,
                    cacheKey: event.coverImageLink!.split("?")[0],
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
                        color: event.status == EventStatusEnum.takesplace
                            ? Colors.green
                            : event.status == EventStatusEnum.cancelled
                                ? Colors.red
                                : event.status == EventStatusEnum.undecided
                                    ? Colors.grey
                                    : null,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Hero(
                      tag: "${event.id} title",
                      child: Text(
                        event.title ?? "Kein Titel",
                        style: Theme.of(context).textTheme.titleLarge?.apply(
                              color: Colors.white,
                            ),
                      ),
                    ),
                  ]),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      DateFormat.yMd().add_jm().format(event.eventDate),
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
