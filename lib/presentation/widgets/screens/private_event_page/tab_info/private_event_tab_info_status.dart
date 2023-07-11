import 'package:chattyevent_app_flutter/core/enums/private_event/private_event_status_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletons/skeletons.dart';
import 'package:chattyevent_app_flutter/application/bloc/current_private_event/current_private_event_cubit.dart';
import 'package:chattyevent_app_flutter/infastructure/dto/private_event/update_private_event_dto.dart';

class PrivateEventTabInfoStatus extends StatefulWidget {
  const PrivateEventTabInfoStatus({super.key});

  @override
  State<PrivateEventTabInfoStatus> createState() =>
      _PrivateEventTabInfoStatusState();
}

class _PrivateEventTabInfoStatusState extends State<PrivateEventTabInfoStatus> {
  late Offset tapXY;
  late RenderBox overlay;

  RelativeRect get relRectSize =>
      RelativeRect.fromSize(tapXY & const Size(40, 40), overlay.size);

  void getPosition(TapDownDetails detail) {
    tapXY = detail.globalPosition;
  }

  _showMenu(BuildContext context, CurrentPrivateEventState state) {
    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
        tapXY.dx,
        tapXY.dy,
        overlay.size.width - tapXY.dx,
        overlay.size.height - tapXY.dy,
      ),
      items: [
        if (state.privateEvent.status != PrivateEventStatusEnum.takesplace) ...[
          PopupMenuItem(
            child: const Text("findet statt"),
            onTap: () => BlocProvider.of<CurrentPrivateEventCubit>(context)
                .updateCurrentPrivateEvent(
              updatePrivateEventDto: UpdatePrivateEventDto(
                status: PrivateEventStatusEnum.takesplace,
              ),
            ),
          ),
        ],
        if (state.privateEvent.status != PrivateEventStatusEnum.undecided) ...[
          PopupMenuItem(
            child: const Text("nicht entschieden"),
            onTap: () => BlocProvider.of<CurrentPrivateEventCubit>(context)
                .updateCurrentPrivateEvent(
              updatePrivateEventDto: UpdatePrivateEventDto(
                status: PrivateEventStatusEnum.undecided,
              ),
            ),
          ),
        ],
        if (state.privateEvent.status != PrivateEventStatusEnum.cancelled) ...[
          PopupMenuItem(
            child: const Text("abgesagt"),
            onTap: () => BlocProvider.of<CurrentPrivateEventCubit>(context)
                .updateCurrentPrivateEvent(
              updatePrivateEventDto: UpdatePrivateEventDto(
                status: PrivateEventStatusEnum.cancelled,
              ),
            ),
          ),
        ],
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    overlay = Overlay.of(context).context.findRenderObject() as RenderBox;

    return BlocBuilder<CurrentPrivateEventCubit, CurrentPrivateEventState>(
      builder: (context, state) {
        return GestureDetector(
          onTapDown: getPosition,
          onTap: state.currentUserAllowedWithPermission(
            permissionCheckValue: state.privateEvent.permissions?.changeStatus,
          )
              ? () => _showMenu(context, state)
              : null,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child:
                state.privateEvent.status == null && state.loadingPrivateEvent
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
                          Text(
                            state.privateEvent.status ==
                                    PrivateEventStatusEnum.takesplace
                                ? "findet statt"
                                : state.privateEvent.status ==
                                        PrivateEventStatusEnum.cancelled
                                    ? "abgesagt"
                                    : state.privateEvent.status ==
                                            PrivateEventStatusEnum.undecided
                                        ? "nicht entschieden"
                                        : "keine daten",
                          )
                        ],
                      ),
          ),
        );
      },
    );
  }
}
