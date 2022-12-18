import 'package:flutter/material.dart';
import 'package:social_media_app_flutter/domain/entities/private_event_entity.dart';

class FilterChipListPrivateEvents extends StatefulWidget {
  final Function(List<PrivateEventEntity>) listChanged;
  final List<PrivateEventEntity> privateEventsToFilter;

  const FilterChipListPrivateEvents({
    super.key,
    required this.listChanged,
    required this.privateEventsToFilter,
  });

  @override
  State<FilterChipListPrivateEvents> createState() =>
      _FilterChipListPrivateEventsState();
}

class _FilterChipListPrivateEventsState
    extends State<FilterChipListPrivateEvents> {
  bool futureEvents = false;
  bool pastEvents = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
      child: SizedBox(
        height: 60,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            InkWell(
              child: Chip(
                label: const Text("Nächste Events"),
                backgroundColor: futureEvents
                    ? Theme.of(context).colorScheme.primaryContainer
                    : null,
              ),
              onTap: () {
                if (futureEvents) {
                  setState(() {
                    futureEvents = false;
                  });
                } else {
                  setState(() {
                    futureEvents = true;
                    pastEvents = false;
                  });
                }

                if (futureEvents) {
                  List<PrivateEventEntity> filteredEvents = [];
                  for (final privateEventToFilter
                      in widget.privateEventsToFilter) {
                    if (DateTime.now()
                        .isBefore(privateEventToFilter.eventDate)) {
                      filteredEvents.add(privateEventToFilter);
                    }
                  }

                  // greatest date last
                  filteredEvents
                      .sort((a, b) => a.eventDate.compareTo(b.eventDate));
                  widget.listChanged(filteredEvents);
                } else {
                  // greatest date last
                  widget.listChanged(widget.privateEventsToFilter);
                }
              },
            ),
            const SizedBox(width: 8),
            InkWell(
              child: Chip(
                label: const Text("Vergangene Events"),
                backgroundColor: pastEvents
                    ? Theme.of(context).colorScheme.primaryContainer
                    : null,
              ),
              onTap: () {
                if (pastEvents) {
                  setState(() {
                    pastEvents = false;
                  });
                } else {
                  setState(() {
                    pastEvents = true;
                    futureEvents = false;
                  });
                }

                if (pastEvents) {
                  setState(() {
                    futureEvents = false;
                  });
                  List<PrivateEventEntity> filteredEvents = [];
                  for (final privateEventToFilter
                      in widget.privateEventsToFilter) {
                    if (DateTime.now()
                        .isAfter(privateEventToFilter.eventDate)) {
                      filteredEvents.add(privateEventToFilter);
                    }
                  }

                  // greatest date first
                  filteredEvents
                      .sort((a, b) => b.eventDate.compareTo(a.eventDate));
                  widget.listChanged(filteredEvents);
                } else {
                  widget.listChanged(widget.privateEventsToFilter);
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
