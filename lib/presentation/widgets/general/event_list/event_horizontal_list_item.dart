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
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 12, left: 8, right: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Hero(
                      tag: "${event.id} title",
                      child: Text(
                        event.title ?? "",
                        style: Theme.of(context).textTheme.titleLarge?.apply(
                              color: Colors.white,
                            ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: event.status == EventStatusEnum.takesplace
                              ? Colors.green
                              : event.status == EventStatusEnum.cancelled
                                  ? Colors.red
                                  : event.status == EventStatusEnum.undecided
                                      ? Theme.of(context).colorScheme.surface
                                      : null,
                          borderRadius: BorderRadius.circular(8)),
                      child: Text(
                        DateFormat.yMd().add_jm().format(event.eventDate),
                        style: Theme.of(context).textTheme.bodySmall?.apply(
                            ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
