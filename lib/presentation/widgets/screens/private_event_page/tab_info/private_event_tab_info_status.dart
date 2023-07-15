import 'package:chattyevent_app_flutter/core/enums/private_event/private_event_status_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletons/skeletons.dart';
import 'package:chattyevent_app_flutter/application/bloc/current_private_event/current_private_event_cubit.dart';
import 'package:chattyevent_app_flutter/infastructure/dto/private_event/update_private_event_dto.dart';

class PrivateEventTabInfoStatus extends StatelessWidget {
  const PrivateEventTabInfoStatus({super.key});

  Widget textWidget(BuildContext context, CurrentPrivateEventState state) {
    String text = "";
    switch (state.privateEvent.status) {
      case PrivateEventStatusEnum.takesplace:
        text = "findet statt";
        break;
      case PrivateEventStatusEnum.cancelled:
        text = "abgesagt";
        break;
      case PrivateEventStatusEnum.undecided:
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
    return BlocBuilder<CurrentPrivateEventCubit, CurrentPrivateEventState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: state.privateEvent.status == null && state.loadingPrivateEvent
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
                            state.privateEvent.permissions?.changeStatus)) ...{
                      PopupMenuButton(
                        initialValue: state.privateEvent.status,
                        onSelected: (value) =>
                            BlocProvider.of<CurrentPrivateEventCubit>(context)
                                .updateCurrentPrivateEvent(
                          updatePrivateEventDto: UpdatePrivateEventDto(
                            status: value,
                          ),
                        ),
                        itemBuilder: (context) => [
                          if (state.privateEvent.status !=
                              PrivateEventStatusEnum.takesplace) ...[
                            const PopupMenuItem(
                              value: PrivateEventStatusEnum.takesplace,
                              child: Text("findet statt"),
                            ),
                          ],
                          if (state.privateEvent.status !=
                              PrivateEventStatusEnum.undecided) ...[
                            const PopupMenuItem(
                              value: PrivateEventStatusEnum.undecided,
                              child: Text("nicht entschieden"),
                            ),
                          ],
                          if (state.privateEvent.status !=
                              PrivateEventStatusEnum.cancelled) ...[
                            const PopupMenuItem(
                              value: PrivateEventStatusEnum.cancelled,
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
