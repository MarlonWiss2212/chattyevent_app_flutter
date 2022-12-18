import 'package:flutter/material.dart';
import 'package:social_media_app_flutter/domain/entities/private_event_entity.dart';
import 'package:social_media_app_flutter/presentation/widgets/event_grid_list.dart';
import 'package:social_media_app_flutter/presentation/widgets/home_page/pages/home_event_page/filter_chip_list_private_events.dart';

class EventGridListWithFilters extends StatefulWidget {
  final List<PrivateEventEntity> privateEvents;
  const EventGridListWithFilters({super.key, required this.privateEvents});

  @override
  State<EventGridListWithFilters> createState() =>
      _EventGridListWithFiltersState();
}

class _EventGridListWithFiltersState extends State<EventGridListWithFilters> {
  List<PrivateEventEntity> filteredPrivateEvents = [];

  @override
  void initState() {
    filteredPrivateEvents = widget.privateEvents;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FilterChipListPrivateEvents(
          listChanged: (filteredEvents) {
            setState(() {
              filteredPrivateEvents = filteredEvents;
            });
          },
          privateEventsToFilter: widget.privateEvents,
        ),
        const SizedBox(height: 8),
        Expanded(
          child: EventGridList(privateEvents: filteredPrivateEvents),
        ),
      ],
    );
    ;
  }
}
