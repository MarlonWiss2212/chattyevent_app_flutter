import 'package:chattyevent_app_flutter/core/enums/event/event_status_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletons/skeletons.dart';
import 'package:chattyevent_app_flutter/application/bloc/current_event/current_event_cubit.dart';
import 'package:chattyevent_app_flutter/infastructure/dto/event/update_event_dto.dart';

class PrivateEventTabInfoStatus extends StatelessWidget {
  const PrivateEventTabInfoStatus({super.key});

  Widget textWidget(BuildContext context, CurrentEventState state) {
    String text = "";
    switch (state.event.status) {
      case EventStatusEnum.takesplace:
        text = "findet statt";
        break;
      case EventStatusEnum.cancelled:
        text = "abgesagt";
        break;
      case EventStatusEnum.undecided:
        text = "nicht entschieden";
        break;
      default:
        text = "keine Daten";
        break;
    }
    return Text(text);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrentEventCubit, CurrentEventState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: state.event.status == null && state.loadingEvent
              ? const SkeletonLine()
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Status: ",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (state.currentUserAllowedWithPermission(
                        permissionCheckValue:
                            state.event.permissions?.changeStatus)) ...{
                      PopupMenuButton(
                        initialValue: state.event.status,
                        onSelected: (value) =>
                            BlocProvider.of<CurrentEventCubit>(context)
                                .updateCurrentEvent(
                          updateEventDto: UpdateEventDto(
                            status: value,
                          ),
                        ),
                        itemBuilder: (context) => [
                          if (state.event.status !=
                              EventStatusEnum.takesplace) ...[
                            const PopupMenuItem(
                              value: EventStatusEnum.takesplace,
                              child: Text("findet statt"),
                            ),
                          ],
                          if (state.event.status !=
                              EventStatusEnum.undecided) ...[
                            const PopupMenuItem(
                              value: EventStatusEnum.undecided,
                              child: Text("nicht entschieden"),
                            ),
                          ],
                          if (state.event.status !=
                              EventStatusEnum.cancelled) ...[
                            const PopupMenuItem(
                              value: EventStatusEnum.cancelled,
                              child: Text("abgesagt"),
                            ),
                          ],
                        ],
                        child: Row(
                          children: [
                            textWidget(context, state),
                            const SizedBox(width: 4),
                            const Icon(Icons.arrow_drop_down, size: 14),
                          ],
                        ),
                      ),
                    } else ...{
                      textWidget(context, state)
                    }
                  ],
                ),
        );
      },
    );
  }
}
