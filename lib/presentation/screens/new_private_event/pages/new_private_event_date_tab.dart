import 'package:auto_route/auto_route.dart';
import 'package:chattyevent_app_flutter/core/enums/calendar/calendar_status_enum.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/user_list/user_list_tile.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:chattyevent_app_flutter/application/bloc/add_private_event/add_private_event_cubit.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/button.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:skeletons/skeletons.dart';

@RoutePage()
class NewPrivateEventDateTab extends StatelessWidget {
  const NewPrivateEventDateTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
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
              BlocProvider.of<AddPrivateEventCubit>(context)
                  .getCalendarTimeUsers();
              return Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Button(
                      color: Theme.of(context).colorScheme.surface,
                      text:
                          "Datum wählen*: ${state.eventDate != null ? DateFormat.yMd().add_jm().format(state.eventDate!) : ""}",
                      onTap: () async {
                        DateTime currentDate = DateTime.now();
                        DateTime? newDate = await showDatePicker(
                          context: context,
                          initialDate: state.eventDate ?? currentDate,
                          firstDate: currentDate,
                          lastDate: currentDate.add(const Duration(days: 3650)),
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
                        BlocProvider.of<AddPrivateEventCubit>(context)
                            .emitState(
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
                      color: Theme.of(context).colorScheme.surface,
                      text:
                          "End Datum wählen: ${state.eventEndDate != null ? DateFormat.yMd().add_jm().format(state.eventEndDate!) : ""}",
                      onTap: () async {
                        DateTime currentDate = DateTime.now();
                        DateTime? newDate = await showDatePicker(
                          context: context,
                          initialDate: state.eventEndDate ?? currentDate,
                          firstDate: currentDate,
                          lastDate: currentDate.add(const Duration(days: 3650)),
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
                        BlocProvider.of<AddPrivateEventCubit>(context)
                            .emitState(
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
        ),
        BlocBuilder<AddPrivateEventCubit, AddPrivateEventState>(
          builder: (context, state) {
            return Expanded(
              child: state.loadingCalendarTimeUsers
                  ? SkeletonListView(
                      spacing: 0,
                      itemBuilder: (p0, p1) {
                        return SkeletonListTile(
                          hasSubtitle: true,
                          titleStyle:
                              const SkeletonLineStyle(width: 100, height: 22),
                          subtitleStyle: const SkeletonLineStyle(
                              width: double.infinity, height: 16),
                          leadingStyle: const SkeletonAvatarStyle(
                            shape: BoxShape.circle,
                          ),
                        );
                      },
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        Icon? trailing;
                        Color? color;
                        if (state.calendarTimeUsers[index].status ==
                            CalendarStatusEnum.doesnothavetime) {
                          trailing = const Icon(
                            Ionicons.close,
                            color: Colors.white,
                            size: 20,
                          );
                          color = Colors.red;
                        } else if (state.calendarTimeUsers[index].status ==
                            CalendarStatusEnum.hastime) {
                          trailing = const Icon(
                            Ionicons.checkmark,
                            color: Colors.white,
                            size: 20,
                          );
                          color = Colors.green;
                        } else {
                          trailing = const Icon(
                            Ionicons.remove,
                            color: Colors.white,
                            size: 20,
                          );
                          color = Colors.grey[800];
                        }

                        return UserListTile(
                          user: state.calendarTimeUsers[index],
                          trailing: Container(
                            decoration: BoxDecoration(
                              color: color,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(4),
                              child: trailing,
                            ),
                          ),
                        );
                      },
                      itemCount: state.calendarTimeUsers.length,
                    ),
            );
          },
        ),
      ],
    );
  }
}
