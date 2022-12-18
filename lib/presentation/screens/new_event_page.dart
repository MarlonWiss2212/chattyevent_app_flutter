import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:social_media_app_flutter/application/bloc/private_event/private_event_bloc.dart';
import 'package:social_media_app_flutter/domain/dto/create_private_event_dto.dart';
import 'package:social_media_app_flutter/presentation/router/router.gr.dart';

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
    return PlatformScaffold(
      appBar: PlatformAppBar(
        title: const Text('Neues Event'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: [
          PlatformTextField(
            controller: titleFieldController,
            hintText: 'Name*',
          ),
          const SizedBox(height: 8),
          PlatformElevatedButton(
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
          PlatformTextField(
            controller: groupchatFieldController,
            hintText: 'Chat*',
          ),
          const SizedBox(height: 8),
          BlocListener<PrivateEventBloc, PrivateEventState>(
            listenWhen: (previous, current) {
              if (current is PrivateEventStateLoaded &&
                  current.createdPrivateEventId != null) {
                return true;
              }
              return false;
            },
            listener: (context, state) {
              if (state is PrivateEventStateLoaded &&
                  state.createdPrivateEventId != null) {
                for (final privateEvent in state.privateEvents) {
                  if (privateEvent.id == state.createdPrivateEventId) {
                    AutoRouter.of(context).replace(
                      PrivateEventPageRoute(
                        privateEventId: privateEvent.id,
                        loadPrivateEvent: false,
                      ),
                    );
                  }
                }
              }
            },
            child: PlatformElevatedButton(
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
