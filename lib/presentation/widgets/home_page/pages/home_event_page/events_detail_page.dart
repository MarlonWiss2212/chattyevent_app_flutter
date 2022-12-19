import 'package:flutter/material.dart';
import 'package:social_media_app_flutter/domain/entities/private_event_entity.dart';
import 'package:social_media_app_flutter/presentation/widgets/event_horizontal_list.dart';

class EventsDetailPage extends StatelessWidget {
  final List<PrivateEventEntity> privateEvents;
  const EventsDetailPage({super.key, required this.privateEvents});

  @override
  Widget build(BuildContext context) {
    List<PrivateEventEntity> futurePrivateEvents = [];
    List<PrivateEventEntity> pastPrivateEvents = [];

    void setFuturePrivateEvents() {
      for (final privateEventToFilter in privateEvents) {
        if (DateTime.now().isBefore(privateEventToFilter.eventDate)) {
          futurePrivateEvents.add(privateEventToFilter);
        }
      }
      // sort so that the first element has the closest date to the current date
      futurePrivateEvents.sort((a, b) => a.eventDate.compareTo(b.eventDate));
    }

    void setPastPrivateEvents() {
      for (final privateEventToFilter in privateEvents) {
        if (DateTime.now().isAfter(privateEventToFilter.eventDate)) {
          pastPrivateEvents.add(privateEventToFilter);
        }
      }
      // sort so that the first element has the newest date
      pastPrivateEvents.sort((a, b) => b.eventDate.compareTo(a.eventDate));
    }

    setFuturePrivateEvents();
    setPastPrivateEvents();

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Text(
              "Nächste Events",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            const SizedBox(height: 8),
            EventHorizontalList(privateEvents: futurePrivateEvents),
            const SizedBox(height: 20),
            const Text(
              "Letzte Events",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            const SizedBox(height: 8),
            EventHorizontalList(privateEvents: pastPrivateEvents),
          ],
        ),
      ),
    );
    ;
  }
}
