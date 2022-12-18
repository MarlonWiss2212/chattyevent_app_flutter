import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app_flutter/domain/entities/private_event_entity.dart';
import 'package:social_media_app_flutter/presentation/router/router.gr.dart';
import 'package:social_media_app_flutter/presentation/widgets/event_horizontal_list_item.dart';

class EventHorizontalList extends StatelessWidget {
  final List<PrivateEventEntity> privateEvents;
  const EventHorizontalList({super.key, required this.privateEvents});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return EventGridListItem(
          privateEvent: privateEvents[index],
          onPress: () {
            AutoRouter.of(context).push(
              PrivateEventPageRoute(
                privateEventId: privateEvents[index].id,
              ),
            );
          },
        );
      },
      itemCount: privateEvents.length,
      separatorBuilder: (context, index) => const SizedBox(width: 8),
    );
  }
}
