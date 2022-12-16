import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app_flutter/application/bloc/private_event/private_event_bloc.dart';
import 'package:social_media_app_flutter/presentation/router/router.gr.dart';
import 'package:social_media_app_flutter/presentation/widgets/event_grid_list.dart';

class Event extends StatefulWidget {
  const Event({super.key});

  @override
  State<Event> createState() => _EventState();
}

class _EventState extends State<Event> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Social Media App'),
      ),
      body: BlocBuilder<PrivateEventBloc, PrivateEventState>(
        bloc: BlocProvider.of(context)..add(PrivateEventsRequestEvent()),
        builder: (context, state) {
          if (state is PrivateEventStateLoaded) {
            return EventGridList(privateEvents: state.privateEvents);
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
