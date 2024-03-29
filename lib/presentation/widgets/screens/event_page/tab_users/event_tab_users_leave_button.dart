import 'package:chattyevent_app_flutter/application/bloc/current_event/current_event_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chattyevent_app_flutter/application/bloc/auth/auth_state.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/dialog/accept_decline_dialog.dart';

class EventTabUsersLeaveButton extends StatelessWidget {
  const EventTabUsersLeaveButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrentEventCubit, CurrentEventState>(
      buildWhen: (p, c) =>
          p.event.privateEventData?.groupchatTo !=
          c.event.privateEventData?.groupchatTo,
      builder: (context, state) {
        if (state.event.privateEventData?.groupchatTo != null) {
          return const SizedBox();
        }
        return ListTile(
          leading: const Icon(
            Icons.logout,
            color: Colors.red,
          ),
          title: const Text(
            "eventPage.tabs.userListTab.leaveEventButton.leaveEventText",
            style: TextStyle(color: Colors.red),
          ).tr(),
          onTap: () async {
            await showDialog(
              context: context,
              builder: (c) {
                return AcceptDeclineDialog(
                  title:
                      "eventPage.tabs.userListTab.leaveEventButton.leaveEventText"
                          .tr(),
                  message:
                      "eventPage.tabs.userListTab.leaveEventButton.leaveEventDescriptionText"
                          .tr(),
                  onNoPress: () => Navigator.of(c).pop(),
                  onYesPress: () => BlocProvider.of<CurrentEventCubit>(context)
                      .deleteUserFromEventViaApi(
                    userId: BlocProvider.of<AuthCubit>(context)
                        .state
                        .currentUser
                        .id,
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
