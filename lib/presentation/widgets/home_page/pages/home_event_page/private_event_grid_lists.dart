import 'package:flutter/material.dart';
import 'package:social_media_app_flutter/domain/entities/private_event_entity.dart';
import 'package:social_media_app_flutter/presentation/widgets/event_horizontal_list.dart';

class PrivateEventGridLists extends StatelessWidget {
  final List<PrivateEventEntity> privateEvents;
  const PrivateEventGridLists({super.key, required this.privateEvents});

  @override
  Widget build(BuildContext context) {
    List<PrivateEventEntity> futurePrivateEvents = [];
    List<PrivateEventEntity> pastPrivateEvents = [];
    List<PrivateEventEntity> otherPrivateEvents = [];

    void sortPrivateEvents() {
      for (final privateEventToFilter in privateEvents) {
        if (privateEventToFilter.eventDate != null &&
            DateTime.now().isBefore(privateEventToFilter.eventDate!)) {
          futurePrivateEvents.add(privateEventToFilter);
        } else if (privateEventToFilter.eventDate != null &&
            DateTime.now().isAfter(privateEventToFilter.eventDate!)) {
          pastPrivateEvents.add(privateEventToFilter);
        } else {
          otherPrivateEvents.add(privateEventToFilter);
        }
      }
      // sort so that the first element has the closest date to the current date
      futurePrivateEvents.sort((a, b) => a.eventDate!.compareTo(b.eventDate!));
      pastPrivateEvents.sort((a, b) => b.eventDate!.compareTo(a.eventDate!));
    }

    sortPrivateEvents();

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (futurePrivateEvents.isNotEmpty) ...[
              const SizedBox(height: 20),
              const Text(
                "Nächste Events",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              const SizedBox(height: 8),
              EventHorizontalList(privateEvents: futurePrivateEvents),
            ],
            if (pastPrivateEvents.isNotEmpty) ...[
              const SizedBox(height: 20),
              const Text(
                "Letzte Events",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              const SizedBox(height: 8),
              EventHorizontalList(privateEvents: pastPrivateEvents),
            ],
            if (otherPrivateEvents.isNotEmpty) ...[
              const SizedBox(height: 20),
              const Text(
                "Events ohne Datum",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              const SizedBox(height: 8),
              EventHorizontalList(privateEvents: otherPrivateEvents),
            ],
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
    ;
  }
}
