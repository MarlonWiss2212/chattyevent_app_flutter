import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:skeletons/skeletons.dart';
import 'package:social_media_app_flutter/application/bloc/private_event/current_private_event_cubit.dart';

class PrivateEventTabInfoEventDate extends StatelessWidget {
  const PrivateEventTabInfoEventDate({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrentPrivateEventCubit, CurrentPrivateEventState>(
      builder: (context, state) {
        if (state.privateEvent.eventDate == null && state.loadingPrivateEvent) {
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
                  state.privateEvent.eventDate != null
                      ? DateFormat.yMd()
                          .add_jm()
                          .format(state.privateEvent.eventDate!)
                      : "Fehler",
                )
              ],
            ),
          );
        }
      },
    );
  }
}
