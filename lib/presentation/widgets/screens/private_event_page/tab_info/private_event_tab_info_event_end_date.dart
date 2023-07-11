import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:skeletons/skeletons.dart';
import 'package:chattyevent_app_flutter/application/bloc/current_private_event/current_private_event_cubit.dart';
import 'package:chattyevent_app_flutter/infastructure/dto/private_event/update_private_event_dto.dart';

class PrivateEventTabInfoEventEndDate extends StatelessWidget {
  const PrivateEventTabInfoEventEndDate({super.key});

  _onChangeDatePress(BuildContext context, DateTime initialDate) async {
    DateTime currentDate = DateTime.now();
    DateTime? newDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: currentDate,
      lastDate: currentDate.add(const Duration(days: 3650)),
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
        eventEndDate: DateTime(
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
        if (state.privateEvent.eventEndDate == null &&
            state.loadingPrivateEvent) {
          return const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: SkeletonLine(),
          );
        } else {
          return InkWell(
            onTap: state.currentUserAllowedWithPermission(
              permissionCheckValue: state.privateEvent.permissions?.changeDate,
            )
                ? () => _onChangeDatePress(
                      context,
                      state.privateEvent.eventEndDate ?? DateTime.now(),
                    )
                : null,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Event End Datum: ",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    state.privateEvent.eventEndDate != null
                        ? DateFormat.yMd()
                            .add_jm()
                            .format(state.privateEvent.eventEndDate!)
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
