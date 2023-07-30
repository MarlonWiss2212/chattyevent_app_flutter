import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletons/skeletons.dart';
import 'package:chattyevent_app_flutter/application/bloc/current_event/current_event_cubit.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/screens/private_event_page/tab_users/tab_users_left_user_list/private_event_tab_users_user_left_list_item.dart';

class PrivateEventTabUsersLeftUserList extends StatelessWidget {
  const PrivateEventTabUsersLeftUserList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrentEventCubit, CurrentEventState>(
      builder: (context, state) {
        if (state.eventLeftUsers.isEmpty && state.loadingPrivateEvent) {
          return SkeletonListTile(
            padding: const EdgeInsets.all(8),
            hasSubtitle: true,
            titleStyle: const SkeletonLineStyle(width: 100, height: 22),
            subtitleStyle:
                const SkeletonLineStyle(width: double.infinity, height: 16),
            leadingStyle: const SkeletonAvatarStyle(
              shape: BoxShape.circle,
            ),
          );
        } else if (state.eventLeftUsers.isNotEmpty) {
          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return PrivateEventTabUsersLeftUserListItem(
                currentEventUser: state.getCurrentEventUser(),
                leftPrivateEventUser: state.eventLeftUsers[index],
                event: state.event,
              );
            },
            itemCount: state.eventLeftUsers.length,
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
