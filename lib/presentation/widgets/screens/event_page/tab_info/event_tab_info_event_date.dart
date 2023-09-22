import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:chattyevent_app_flutter/application/bloc/current_event/current_event_cubit.dart';
import 'package:chattyevent_app_flutter/infastructure/dto/event/update_event_dto.dart';

class EventTabInfoEventDate extends StatelessWidget {
  const EventTabInfoEventDate({super.key});

  _onChangeDatePress(BuildContext context, DateTime initialDate) async {
    DateTime currentDate = DateTime.now();
    DateTime? newDate = await showDatePicker(
      keyboardType: const TextInputType.numberWithOptions(
        decimal: true,
      ),
      context: context,
      initialDate: initialDate,
      firstDate: currentDate,
      lastDate: currentDate.add(const Duration(days: 3650)),
    );
    if (newDate == null) return;
    TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(
        hour: initialDate.hour,
        minute: initialDate.minute,
      ),
    );

    if (newTime == null) return;
    BlocProvider.of<CurrentEventCubit>(context).updateCurrentEvent(
      updateEventDto: UpdateEventDto(
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
    return BlocBuilder<CurrentEventCubit, CurrentEventState>(
        builder: (context, state) {
      return InkWell(
        onTap: state.currentUserAllowedWithPermission(
          permissionCheckValue: state.event.permissions?.changeDate,
        )
            ? () => _onChangeDatePress(
                  context,
                  state.event.eventDate,
                )
            : null,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "eventPage.tabs.infoTab.eventDateText",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ).tr(),
              Text(
                DateFormat.yMd().add_jm().format(state.event.eventDate),
              )
            ],
          ),
        ),
      );
    });
  }
}
