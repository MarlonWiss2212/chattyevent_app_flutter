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
    double viewportFraction = min(
      (300 / MediaQuery.of(context).size.width).toDouble(),
      1,
    );
    final pageController = PageController(viewportFraction: viewportFraction);
    // to make the box in the 4 by 3 ratio just like the image is
    // -16 is the padding
    final width = (MediaQuery.of(context).size.width * viewportFraction) - 16;
    final height = width / 4 * 3;

    return SizedBox(
      height: height,
      child: PageView.builder(
        padEnds: false,
        controller: pageController,
        scrollDirection: Axis.horizontal,
        physics: const PageScrollPhysics(),
        itemBuilder: (context, index) {
          return FractionallySizedBox(
            widthFactor: .95,
            alignment: Alignment.centerLeft,
            child: EventGridListItem(
              height: height,
              width: width, // will be ignored because of page view
              privateEvent: privateEvents[index],
              onPress: () {
                AutoRouter.of(context).push(
                  PrivateEventPageRoute(
                    privateEventId: privateEvents[index].id,
                  ),
                );
              },
            ),
          );
        },
        itemCount: privateEvents.length,
      ),
    );
  }
}
