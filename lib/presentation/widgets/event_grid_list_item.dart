import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:social_media_app_flutter/domain/entities/private_event_entity.dart';

class EventGridListItem extends StatelessWidget {
  final PrivateEventEntity privateEvent;
  final Function? onLongPress;
  final Function? onPress;
  final Color? backgroundColor;

  const EventGridListItem({
    super.key,
    required this.privateEvent,
    this.onLongPress,
    this.onPress,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: const BorderRadius.all(Radius.circular(8.0)),
      onLongPress: onLongPress == null ? null : () => onLongPress!(),
      onTap: onPress == null ? null : () => onPress!(),
      child: Ink(
        child: Card(
          elevation: 0,
          child: Container(
            padding: const EdgeInsets.all(8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  privateEvent.title ?? "Kein Titel",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
