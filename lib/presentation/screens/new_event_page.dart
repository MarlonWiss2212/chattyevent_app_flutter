import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:social_media_app_flutter/application/bloc/private_event/private_event_bloc.dart';
import 'package:social_media_app_flutter/domain/dto/create_private_event_dto.dart';

class NewPrivateEventPage extends StatefulWidget {
  const NewPrivateEventPage({super.key});

  @override
  State<NewPrivateEventPage> createState() => _NewPrivateEventPageState();
}

class _NewPrivateEventPageState extends State<NewPrivateEventPage> {
  DateTime date = DateTime.now();
  final titleFieldController = TextEditingController();
  final groupchatFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Neues Event'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: [
          TextField(
            controller: titleFieldController,
            decoration: const InputDecoration(
              hintText: 'Name*',
            ),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            child: Text("Datum wählen: $date"),
            onPressed: () async {
              DateTime currentDate = DateTime.now();
              DateTime? newDate = await showDatePicker(
                context: context,
                initialDate: date,
                firstDate: currentDate,
                lastDate: DateTime(currentDate.year + 10),
              );
              TimeOfDay currentTime = TimeOfDay.now();
              TimeOfDay? newTime = await showTimePicker(
                context: context,
                initialTime: currentTime,
              );

              if (newDate == null || newTime == null) return;
              setState(() {
                date = DateTime(
                  newDate.year,
                  newDate.month,
                  newDate.day,
                  newTime.hour,
                  newTime.minute,
                );
              });
            },
          ),
          TextField(
            controller: groupchatFieldController,
            decoration: const InputDecoration(
              hintText: 'Chat*',
            ),
          ),
          const SizedBox(height: 8),
          BlocListener<PrivateEventBloc, PrivateEventState>(
            listener: (context, state) {
              AutoRouter.of(context).pop();
            },
            child: ElevatedButton(
              onPressed: () {
                BlocProvider.of<PrivateEventBloc>(context).add(
                  PrivateEventCreateEvent(
                    createPrivateEventDto: CreatePrivateEventDto(
                      title: titleFieldController.text,
                      eventDate: date,
                      connectedGroupchat: groupchatFieldController.text,
                    ),
                  ),
                );
              },
              child: const Text("Speichern"),
            ),
          ),
        ],
      ),
    );
  }
}
