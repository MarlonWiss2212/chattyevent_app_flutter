import 'package:chattyevent_app_flutter/core/enums/event/event_status_enum.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletons/skeletons.dart';
import 'package:chattyevent_app_flutter/application/bloc/current_event/current_event_cubit.dart';
import 'package:chattyevent_app_flutter/infastructure/dto/event/update_event_dto.dart';

class EventTabInfoStatus extends StatelessWidget {
  const EventTabInfoStatus({super.key});

  Widget textWidget(BuildContext context, CurrentEventState state) {
    String text = "";
    switch (state.event.status) {
      case EventStatusEnum.takesplace:
        text = "eventPage.tabs.infoTab.statusButton.takesPlaceText".tr();
        break;
      case EventStatusEnum.cancelled:
        text = "eventPage.tabs.infoTab.statusButton.cancelledText".tr();
        break;
      case EventStatusEnum.undecided:
        text = "eventPage.tabs.infoTab.statusButton.undecidedText".tr();
        break;
      default:
        text = "";
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
                      "eventPage.tabs.infoTab.statusButton.leftText",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ).tr(),
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
                            PopupMenuItem(
                              value: EventStatusEnum.takesplace,
                              child: const Text(
                                "eventPage.tabs.infoTab.statusButton.takesPlaceText",
                              ).tr(),
                            ),
                          ],
                          if (state.event.status !=
                              EventStatusEnum.undecided) ...[
                            PopupMenuItem(
                              value: EventStatusEnum.undecided,
                              child: const Text(
                                "eventPage.tabs.infoTab.statusButton.undecidedText",
                              ).tr(),
                            ),
                          ],
                          if (state.event.status !=
                              EventStatusEnum.cancelled) ...[
                            PopupMenuItem(
                              value: EventStatusEnum.undecided,
                              child: const Text(
                                "eventPage.tabs.infoTab.statusButton.cancelledText",
                              ).tr(),
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
