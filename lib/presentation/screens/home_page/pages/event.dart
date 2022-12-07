import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app_flutter/application/bloc/private_event/private_event_bloc.dart';
import 'package:social_media_app_flutter/presentation/router/router.gr.dart';
import 'package:social_media_app_flutter/presentation/widgets/event_list_item.dart';

class Event extends StatefulWidget {
  const Event({super.key});

  @override
  State<Event> createState() => _EventState();
}

class _EventState extends State<Event> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<PrivateEventBloc, PrivateEventState>(
        bloc: BlocProvider.of(context)..add(PrivateEventsRequestEvent()),
        builder: (context, state) {
          if (state is PrivateEventStateLoaded) {
            return GridView.builder(
              padding: const EdgeInsets.all(8),
              itemBuilder: (context, index) {
                return EventListItem(
                  privateEvent: state.privateEvents[index],
                  onPress: () {
                    AutoRouter.of(context).push(
                      PrivateEventPageRoute(
                        privateEvent: state.privateEvents[index],
                      ),
                    );
                  },
                );
              },
              itemCount: state.privateEvents.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: max(
                  (MediaQuery.of(context).size.width ~/ 225).toInt(),
                  1,
                ),
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
              ),
            );
          } else if (state is PrivateEventStateLoading) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return Center(
              child: TextButton(
                child: Text(
                  state is PrivateEventStateError
                      ? state.message
                      : "Daten laden",
                ),
                onPressed: () => BlocProvider.of<PrivateEventBloc>(context).add(
                  PrivateEventsRequestEvent(),
                ),
              ),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => AutoRouter.of(context).push(
          const NewPrivateEventPageRoute(),
        ),
        icon: const Icon(Icons.event),
        label: const Text('Neues Event'),
      ),
    );
  }
}
