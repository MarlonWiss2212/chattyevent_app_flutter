import 'package:flutter/material.dart';
import 'package:social_media_app_flutter/domain/entities/private_event_entity.dart';

class InfoTab extends StatelessWidget {
  final PrivateEventEntity privateEvent;
  const InfoTab({required this.privateEvent, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Center(
        child: Text(privateEvent.title ?? "Kein Titel"),
      ),
    );
  }
}
