import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletons/skeletons.dart';
import 'package:chattyevent_app_flutter/application/bloc/current_event/current_event_cubit.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/screens/event_page/tab_users/tab_users_left_user_list/event_tab_users_user_left_list_item.dart';

class EventTabUsersLeftUserList extends StatelessWidget {
  const EventTabUsersLeftUserList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrentEventCubit, CurrentEventState>(
      builder: (context, state) {
        return Column(
          children: [
            Center(
              child: Text(
                "eventPage.tabs.userListTab.leftUserList.pastMembers",
                style: Theme.of(context).textTheme.titleMedium,
              ).tr(args: [state.eventLeftUsers.length.toString()]),
            ),
            if (state.eventUsers.isEmpty && state.loadingEvent) ...[
              const SizedBox(height: 8),
              SkeletonListTile(
                padding: const EdgeInsets.all(8),
                hasSubtitle: true,
                titleStyle: const SkeletonLineStyle(width: 100, height: 22),
                subtitleStyle:
                    const SkeletonLineStyle(width: double.infinity, height: 16),
                leadingStyle: const SkeletonAvatarStyle(
                  shape: BoxShape.circle,
                ),
              ),
            ] else if (state.eventUsers.isNotEmpty) ...[
              const SizedBox(height: 8),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return PrivateEventTabUsersLeftUserListItem(
                    key: ObjectKey(state.eventLeftUsers[index]),
                    state: state,
                    leftPrivateEventUser: state.eventLeftUsers[index],
                    event: state.event,
                  );
                },
                itemCount: state.eventLeftUsers.length,
              ),
            ]
          ],
        );
      },
    );
  }
}
