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
    return SizedBox(
      height: 250,
      child: PageView.builder(
        padEnds: false,
        controller: PageController(
          viewportFraction: min(
            (300 / MediaQuery.of(context).size.width).toDouble(),
            1,
          ),
        ),
        scrollDirection: Axis.horizontal,
        physics: const PageScrollPhysics(),
        itemBuilder: (context, index) {
          return EventGridListItem(
            height: 250,
            width: 250, // will be ignored because of page view
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
        //separatorBuilder: (context, index) => const SizedBox(width: 8),
      ),
    );
  }
}
