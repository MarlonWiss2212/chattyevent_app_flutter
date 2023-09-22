import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chattyevent_app_flutter/application/bloc/current_event/current_event_cubit.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/dialog/accept_decline_dialog.dart';

class EventTabInfoDeleteButton extends StatelessWidget {
  const EventTabInfoDeleteButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrentEventCubit, CurrentEventState>(
      builder: (context, state) {
        if (state.getCurrentEventUser()?.id == state.event.createdBy) {
          return IconButton(
            onPressed: () async {
              await showDialog(
                context: context,
                builder: (c) {
                  return AcceptDeclineDialog(
                    title:
                        "eventPage.tabs.infoTab.deleteButton.dialog.title".tr(),
                    message:
                        "eventPage.tabs.infoTab.deleteButton.dialog.message"
                            .tr(),
                    onNoPress: () => Navigator.of(c).pop(),
                    onYesPress: () =>
                        BlocProvider.of<CurrentEventCubit>(context)
                            .deleteCurrentEventViaApi(),
                  );
                },
              );
            },
            icon: const Icon(
              Icons.delete,
            ),
          );
        }
        return const SizedBox();
      },
    );
  }
}
