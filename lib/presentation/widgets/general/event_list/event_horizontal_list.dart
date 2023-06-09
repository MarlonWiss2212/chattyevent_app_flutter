import 'package:auto_route/auto_route.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:chattyevent_app_flutter/application/bloc/current_private_event/current_private_event_cubit.dart';
import 'package:chattyevent_app_flutter/presentation/router/router.gr.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/event_list/event_horizontal_list_item.dart';

class EventHorizontalList extends StatelessWidget {
  final List<CurrentPrivateEventState> privateEventStates;
  const EventHorizontalList({super.key, required this.privateEventStates});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width.toDouble() - 16;
    final double height = width / 4 * 3;

    final double itemWidth = MediaQuery.of(context).size.width.toDouble() - 40;
    final double itemHeight = width / 4 * 3;

    return Swiper(
      loop: false,
      layout: SwiperLayout.STACK,
      viewportFraction: .9,
      containerHeight: height,
      containerWidth: width,
      itemHeight: itemHeight,
      itemWidth: itemWidth,
      itemCount: privateEventStates.length,
      itemBuilder: (context, index) {
        return EventHorizontalListItem(
          height: height,
          width: width,
          privateEvent: privateEventStates[index].privateEvent,
          onPress: () {
            AutoRouter.of(context).push(
              PrivateEventWrapperPageRoute(
                privateEventStateToSet: privateEventStates[index],
                privateEventId: privateEventStates[index].privateEvent.id,
              ),
            );
          },
        );
      },
    );
  }
}
