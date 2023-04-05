import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletons/skeletons.dart';
import 'package:social_media_app_flutter/application/bloc/private_event/current_private_event_cubit.dart';
import 'package:social_media_app_flutter/presentation/router/router.gr.dart';
import 'package:social_media_app_flutter/presentation/widgets/screens/private_event_page/tab_users/tab_users_user_list/private_event_tab_users_user_list_item.dart';

class PrivateEventTabUsersUserList extends StatelessWidget {
  const PrivateEventTabUsersUserList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrentPrivateEventCubit, CurrentPrivateEventState>(
      builder: (context, state) {
        return Column(
          children: [
            Center(
              child: Text(
                "Mitglieder die da sein werden: ${state.privateEventUsers.where((element) => element.privateEventUser.status == "ACCEPTED").length.toString()}",
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            const SizedBox(height: 8),
            if (state.getCurrentPrivateEventUser() != null &&
                state.privateEvent.groupchatTo == null &&
                state
                        .getCurrentPrivateEventUser()
                        ?.privateEventUser
                        .organizer !=
                    false) ...{
              ListTile(
                leading: const Icon(
                  Icons.person_add,
                  color: Colors.green,
                ),
                title: const Text(
                  "User zum Event hinzufügen",
                  style: TextStyle(color: Colors.green),
                ),
                onTap: () {
                  AutoRouter.of(context).push(
                    const PrivateEventInviteUserPageRoute(),
                  );
                },
              )
            },
            if (state.privateEventUsers.isEmpty &&
                state.loadingPrivateEvent) ...[
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
            ] else if (state.privateEventUsers.isNotEmpty) ...[
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return PrivateEventTabUsersUserListItem(
                    currentPrivatEventUser: state.getCurrentPrivateEventUser(),
                    privateEventUser: state.privateEventUsers[index],
                    privateEvent: state.privateEvent,
                  );
                },
                itemCount: state.privateEventUsers.length,
              ),
            ]
          ],
        );
      },
    );
  }
}
