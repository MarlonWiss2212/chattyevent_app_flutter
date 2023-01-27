import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app_flutter/domain/entities/private_event/private_event_entity.dart';
import 'package:social_media_app_flutter/presentation/router/router.gr.dart';
import 'package:social_media_app_flutter/presentation/widgets/circle_image/cirlce_image.dart';

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
            PrivateEventPageRoute(privateEventId: privateEvent.id),
          ),
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: Center(
              child: Row(
                children: [
                  CircleImage(
                    height: 40,
                    width: 40,
                    imageLink: privateEvent.coverImageLink,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    privateEvent.title ?? "Kein Titel",
                    style: Theme.of(context).textTheme.labelMedium,
                    overflow: TextOverflow.ellipsis,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
