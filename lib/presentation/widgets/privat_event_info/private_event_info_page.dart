import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:social_media_app_flutter/domain/entities/private_event_entity.dart';

class PrivateEventInfoPage extends StatelessWidget {
  final PrivateEventEntity privateEvent;
  const PrivateEventInfoPage({super.key, required this.privateEvent});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          // Profile Image
          SizedBox(
            width: size.width,
            height: 300,
            child: const Card(),
          ),
          // name
          Container(
            margin: const EdgeInsets.only(top: 20, bottom: 20),
            child: Text(
              privateEvent.title ?? "Kein Titel",
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          // event date
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Event Datum: ",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                privateEvent.eventDate != null
                    ? DateFormat.yMd().add_jm().format(privateEvent.eventDate!)
                    : "Kein Datum",
              )
            ],
          )
        ],
      ),
    );
  }
}
