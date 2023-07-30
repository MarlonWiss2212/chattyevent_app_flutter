import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:chattyevent_app_flutter/application/bloc/current_event/current_event_cubit.dart';
import 'package:chattyevent_app_flutter/presentation/router/router.gr.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/event_list/event_horizontal_list_item.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';

class EventHorizontalList extends StatelessWidget {
  final List<CurrentEventState> eventStates;
  const EventHorizontalList({super.key, required this.eventStates});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width.toDouble() - 16;
    final double height = width / 4 * 3;

    return SizedBox(
      height: height,
      width: width,
      child: CarouselSlider.builder(
        slideTransform: const RotateDownTransform(),
        slideBuilder: (index) {
          return EventHorizontalListItem(
            height: height,
            width: width,
            event: eventStates[index].event,
            onPress: () {
              AutoRouter.of(context).push(
                EventWrapperRoute(
                  eventStateToSet: eventStates[index],
                  eventId: eventStates[index].event.id,
                ),
              );
            },
          );
        },
        itemCount: eventStates.length,
      ),
    );
  }
}
