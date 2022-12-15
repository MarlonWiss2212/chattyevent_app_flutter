import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app_flutter/domain/entities/private_event_entity.dart';
import 'package:social_media_app_flutter/presentation/router/router.gr.dart';
import 'package:social_media_app_flutter/presentation/widgets/event_grid_list_item.dart';

class EventGridList extends StatelessWidget {
  final List<PrivateEventEntity> privateEvents;
  const EventGridList({super.key, required this.privateEvents});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(8),
      itemBuilder: (context, index) {
        return EventGridListItem(
          privateEvent: privateEvents[index],
          onPress: () {
            AutoRouter.of(context).push(
              PrivateEventPageRoute(
                privateEvent: privateEvents[index],
              ),
            );
          },
        );
      },
      itemCount: privateEvents.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: max(
          (MediaQuery.of(context).size.width ~/ 225).toInt(),
          1,
        ),
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
      ),
    );
  }
}
