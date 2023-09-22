import 'package:chattyevent_app_flutter/application/bloc/current_event/current_event_cubit.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/screens/event_page/tab_users/tab_invitation_list/event_tab_invitation_list_item.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletons/skeletons.dart';

class EventTabInvitationList extends StatelessWidget {
  const EventTabInvitationList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrentEventCubit, CurrentEventState>(
      builder: (context, state) {
        return Column(
          children: [
            Text(
              "eventPage.tabs.userListTab.invitationList.invitedUsersCount",
              style: Theme.of(context).textTheme.titleMedium,
              overflow: TextOverflow.ellipsis,
            ).tr(args: [state.invitations.length.toString()]),
            if (state.invitations.isEmpty && state.loadingInvitations) ...[
              const SizedBox(height: 8),
              SkeletonListTile(
                hasSubtitle: true,
                hasLeading: false,
                titleStyle: const SkeletonLineStyle(
                  width: double.infinity,
                  height: 22,
                ),
                subtitleStyle: const SkeletonLineStyle(
                  width: double.infinity,
                  height: 16,
                ),
              ),
            ] else if (state.invitations.isNotEmpty) ...{
              const SizedBox(height: 8),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return EventTabInvitationListItem(
                    key: ObjectKey(state.invitations[index]),
                    invitation: state.invitations[index],
                  );
                },
                itemCount: state.invitations.length,
              ),
            }
          ],
        );
      },
    );
  }
}
