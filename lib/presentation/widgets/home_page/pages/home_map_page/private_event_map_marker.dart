import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app_flutter/domain/entities/private_event/private_event_entity.dart';
import 'package:social_media_app_flutter/presentation/router/router.gr.dart';

class PrivateEventMapMarker extends StatelessWidget {
  final PrivateEventEntity privateEvent;
  const PrivateEventMapMarker({super.key, required this.privateEvent});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      height: 50,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: InkWell(
          onTap: () => AutoRouter.of(context).push(
            PrivateEventPageRoute(
              privateEventId: privateEvent.id,
              privateEventToSet: privateEvent,
              loadPrivateEventFromApiToo: true,
            ),
          ),
          child: Row(
            children: [
              if (privateEvent.coverImageLink != null) ...{
                Container(
                  height: 66.66667,
                  width: 50,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Hero(
                      tag: "${privateEvent.id} coverImage",
                      child: Image.network(
                        privateEvent.coverImageLink!,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              },
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Hero(
                    tag: "${privateEvent.id} title",
                    child: Text(
                      privateEvent.title ?? "Kein Titel",
                      style: Theme.of(context).textTheme.labelMedium,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
