import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:skeletons/skeletons.dart';
import 'package:social_media_app_flutter/application/bloc/private_event/current_private_event_cubit.dart';
import 'package:social_media_app_flutter/core/dto/private_event/update_private_event_dto.dart';

class PrivateEventTabInfoEventDate extends StatelessWidget {
  const PrivateEventTabInfoEventDate({super.key});

  _onChangeDatePress(BuildContext context, DateTime initialDate) async {
    DateTime currentDate = DateTime.now();
    DateTime? newDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: currentDate,
      lastDate: DateTime(currentDate.year + 10),
    );
    TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(
        hour: initialDate.hour,
        minute: initialDate.minute,
      ),
    );

    if (newDate == null || newTime == null) return;
    BlocProvider.of<CurrentPrivateEventCubit>(context)
        .updateCurrentPrivateEvent(
      updatePrivateEventDto: UpdatePrivateEventDto(
        eventDate: DateTime(
          newDate.year,
          newDate.month,
          newDate.day,
          newTime.hour,
          newTime.minute,
        ),
      ),
    );
  }

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
          return InkWell(
            onTap: state
                        .getCurrentPrivateEventUser()
                        ?.privateEventUser
                        .organizer ==
                    true
                ? () => _onChangeDatePress(
                      context,
                      state.privateEvent.eventDate ?? DateTime.now(),
                    )
                : null,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
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
                        : "",
                  )
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
