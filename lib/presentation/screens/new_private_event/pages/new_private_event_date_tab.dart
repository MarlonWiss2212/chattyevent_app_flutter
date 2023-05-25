import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:chattyevent_app_flutter/application/bloc/add_private_event/add_private_event_cubit.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/button.dart';
import 'package:intl/intl.dart';

class NewPrivateEventDateTab extends StatelessWidget {
  const NewPrivateEventDateTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(8),
      child: BlocBuilder<AddPrivateEventCubit, AddPrivateEventState>(
        buildWhen: (previous, current) {
          if (previous.eventEndDate != current.eventEndDate) {
            return true;
          }
          if (previous.eventDate != current.eventDate) {
            return true;
          }
          return false;
        },
        builder: (context, state) {
          return Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: Button(
                  color: Theme.of(context).colorScheme.secondaryContainer,
                  text:
                      "Datum wählen*: ${state.eventDate != null ? DateFormat.yMd().add_jm().format(state.eventDate!) : ""}",
                  onTap: () async {
                    DateTime currentDate = DateTime.now();
                    DateTime? newDate = await showDatePicker(
                      context: context,
                      initialDate: state.eventDate ?? currentDate,
                      firstDate: currentDate,
                      lastDate: DateTime(currentDate.year + 10),
                    );
                    TimeOfDay? newTime = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay(
                        hour: state.eventDate != null
                            ? state.eventDate!.hour
                            : currentDate.hour,
                        minute: state.eventDate != null
                            ? state.eventDate!.minute
                            : currentDate.minute,
                      ),
                    );

                    if (newDate == null || newTime == null) return;
                    BlocProvider.of<AddPrivateEventCubit>(context).emitState(
                      eventDate: DateTime(
                        newDate.year,
                        newDate.month,
                        newDate.day,
                        newTime.hour,
                        newTime.minute,
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                child: Button(
                  color: Theme.of(context).colorScheme.secondaryContainer,
                  text:
                      "End Datum wählen: ${state.eventEndDate != null ? DateFormat.yMd().add_jm().format(state.eventEndDate!) : ""}",
                  onTap: () async {
                    DateTime currentDate = DateTime.now();
                    DateTime? newDate = await showDatePicker(
                      context: context,
                      initialDate: state.eventEndDate ?? currentDate,
                      firstDate: currentDate,
                      lastDate: DateTime(currentDate.year + 10),
                    );
                    TimeOfDay? newTime = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay(
                        hour: state.eventEndDate != null
                            ? state.eventEndDate!.hour
                            : currentDate.hour,
                        minute: state.eventEndDate != null
                            ? state.eventEndDate!.minute
                            : currentDate.minute,
                      ),
                    );

                    if (newDate == null || newTime == null) return;
                    BlocProvider.of<AddPrivateEventCubit>(context).emitState(
                      eventEndDate: DateTime(
                        newDate.year,
                        newDate.month,
                        newDate.day,
                        newTime.hour,
                        newTime.minute,
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 8),
            ],
          );
        },
      ),
    );
  }
}
