import 'dart:math';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:chattyevent_app_flutter/application/bloc/current_event/current_event_cubit.dart';
import 'package:chattyevent_app_flutter/presentation/router/router.gr.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/event_list/event_horizontal_list_item.dart';

class EventHorizontalList extends StatelessWidget {
  final List<CurrentEventState> eventStates;
  const EventHorizontalList({super.key, required this.eventStates});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width - 16;
    final double viewportFraction = min(
      (350 / screenWidth).toDouble(),
      1,
    );
    final pageController = PageController(viewportFraction: viewportFraction);

    final width = screenWidth * viewportFraction;
    final height = width / 4 * 3;

    Widget addPadding({
      required int index,
      required BuildContext context,
      required Widget child,
    }) {
      if (eventStates.length == index) {
        return child;
      }
      return Padding(padding: const EdgeInsets.only(right: 10), child: child);
    }

    return SizedBox(
      height: height,
      child: PageView.builder(
        padEnds: false,
        physics: const PageScrollPhysics(),
        controller: pageController,
        itemBuilder: (context, index) => addPadding(
          context: context,
          index: index,
          child: EventHorizontalListItem(
            key: ObjectKey(eventStates[index].event),
            event: eventStates[index].event,
            width: width,
            height: height,
            onPress: () {
              AutoRouter.of(context).push(
                EventWrapperRoute(
                  eventStateToSet: eventStates[index],
                  eventId: eventStates[index].event.id,
                ),
              );
            },
          ),
        ),
        itemCount: eventStates.length,
      ),
    );
  }
}
