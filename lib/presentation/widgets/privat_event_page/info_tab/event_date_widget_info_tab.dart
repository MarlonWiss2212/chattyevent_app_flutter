import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:skeletons/skeletons.dart';
import 'package:social_media_app_flutter/application/bloc/private_event/current_private_event_cubit.dart';

class EventDateWidgetInfoTab extends StatelessWidget {
  final CurrentPrivateEventState privateEventState;
  const EventDateWidgetInfoTab({
    super.key,
    required this.privateEventState,
  });

  @override
  Widget build(BuildContext context) {
    if (privateEventState.privateEvent.eventDate == null &&
        privateEventState.loadingPrivateEvent) {
      return const Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.0),
        child: SkeletonLine(),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Event Datum: ",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              privateEventState.privateEvent.eventDate != null
                  ? DateFormat.yMd()
                      .add_jm()
                      .format(privateEventState.privateEvent.eventDate!)
                  : "Fehler",
            )
          ],
        ),
      );
    }
  }
}
