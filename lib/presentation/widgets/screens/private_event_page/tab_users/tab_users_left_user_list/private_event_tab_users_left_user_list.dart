import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletons/skeletons.dart';
import 'package:social_media_app_flutter/application/bloc/private_event/current_private_event_cubit.dart';
import 'package:social_media_app_flutter/presentation/widgets/screens/private_event_page/tab_users/tab_users_left_user_list/private_event_tab_users_user_left_list_item.dart';

class PrivateEventTabUsersLeftUserList extends StatelessWidget {
  const PrivateEventTabUsersLeftUserList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrentPrivateEventCubit, CurrentPrivateEventState>(
      builder: (context, state) {
        if (state.privateEventLeftUsers.isEmpty && state.loadingPrivateEvent) {
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
        } else if (state.privateEventLeftUsers.isNotEmpty) {
          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return PrivateEventTabUsersLeftUserListItem(
                currentPrivatEventUser: state.getCurrentPrivateEventUser(),
                leftPrivateEventUser: state.privateEventLeftUsers[index],
                privateEvent: state.privateEvent,
              );
            },
            itemCount: state.privateEventLeftUsers.length,
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}