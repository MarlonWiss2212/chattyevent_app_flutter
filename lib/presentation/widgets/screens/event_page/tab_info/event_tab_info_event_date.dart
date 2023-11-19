import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chattyevent_app_flutter/application/bloc/current_event/current_event_cubit.dart';
import 'package:chattyevent_app_flutter/infastructure/dto/event/update_event_dto.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:ionicons/ionicons.dart';

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

  _onChangeEndDatePress(BuildContext context, DateTime initialDate) async {
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
    return StaggeredGridTile.count(
      crossAxisCellCount: 1,
      mainAxisCellCount: 1,
      child: BlocBuilder<CurrentEventCubit, CurrentEventState>(
        builder: (context, state) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Theme.of(context).colorScheme.surface,
            ),
            padding: const EdgeInsets.all(8.0),
            child: Material(
              color: Colors.transparent,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(
                        Ionicons.calendar_clear,
                        size: 20,
                      ),
                      const SizedBox(width: 12),
                      Text(
                        "eventPage.tabs.infoTab.eventDateText",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ).tr()
                    ],
                  ),
                  Wrap(
                    children: [
                      InkWell(
                        borderRadius: BorderRadius.circular(8),
                        onTap: state.currentUserAllowedWithPermission(
                          permissionCheckValue:
                              state.event.permissions?.changeDate,
                        )
                            ? () => _onChangeDatePress(
                                  context,
                                  state.event.eventDate,
                                )
                            : null,
                        child: Text(
                          DateFormat.yMd().add_jm().format(
                                state.event.eventDate,
                              ),
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                      ),
                      Text(
                        " - ",
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      if (state.event.eventEndDate != null) ...{
                        Wrap(
                          children: [
                            InkWell(
                              borderRadius: BorderRadius.circular(8),
                              onTap: state.currentUserAllowedWithPermission(
                                permissionCheckValue:
                                    state.event.permissions?.changeDate,
                              )
                                  ? () => _onChangeEndDatePress(
                                        context,
                                        state.event.eventDate,
                                      )
                                  : null,
                              child: Text(
                                DateFormat.yMd().add_jm().format(
                                      state.event.eventEndDate!,
                                    ),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ),
                            if (state.currentUserAllowedWithPermission(
                              permissionCheckValue:
                                  state.event.permissions?.changeDate,
                            )) ...{
                              IconButton(
                                iconSize: 20,
                                padding: const EdgeInsets.all(0),
                                visualDensity: VisualDensity.compact,
                                onPressed: () =>
                                    BlocProvider.of<CurrentEventCubit>(context)
                                        .updateCurrentEvent(
                                  updateEventDto: UpdateEventDto(
                                    removeEventEndDate: true,
                                  ),
                                ),
                                icon: const Icon(Icons.close),
                              ),
                            }
                          ],
                        ),
                      } else ...{
                        InkWell(
                          borderRadius: BorderRadius.circular(8),
                          onTap: state.currentUserAllowedWithPermission(
                            permissionCheckValue:
                                state.event.permissions?.changeDate,
                          )
                              ? () => _onChangeEndDatePress(
                                    context,
                                    state.event.eventDate,
                                  )
                              : null,
                          child: Text(
                            "eventPage.tabs.infoTab.eventEndDateText",
                            style:
                                Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                          ).tr(),
                        ),
                      }
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
