import 'package:flutter/material.dart';
import 'package:social_media_app_flutter/presentation/widgets/event_list.dart';

class Event extends StatefulWidget {
  const Event({super.key});

  @override
  State<Event> createState() => _EventState();
}

class _EventState extends State<Event> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const EventList(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => {Navigator.pushNamed(context, '/newEvent')},
        icon: const Icon(Icons.event),
        label: const Text('Neues Event'),
      ),
    );
  }
}
