import 'package:auto_route/auto_route.dart';
import 'package:chattyevent_app_flutter/core/enums/event/event_user/event_user_status_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletons/skeletons.dart';
import 'package:chattyevent_app_flutter/application/bloc/current_event/current_event_cubit.dart';
import 'package:chattyevent_app_flutter/presentation/router/router.gr.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/screens/event_page/tab_users/tab_users_user_list/event_tab_users_user_list_item.dart';

class EventTabUsersUserList extends StatelessWidget {
  const EventTabUsersUserList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrentEventCubit, CurrentEventState>(
      builder: (context, state) {
        return Column(
          children: [
            Center(
              child: Text(
                "Mitglieder die da sein werden: ${state.eventUsers.where((element) => element.status == EventUserStatusEnum.accapted).length.toString()}",
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            const SizedBox(height: 8),
            if (state.event.groupchatTo == null &&
                state.currentUserAllowedWithPermission(
                    permissionCheckValue:
                        state.event.permissions?.addUsers)) ...{
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
                    const EventInviteUserRoute(),
                  );
                },
              )
            },
            if (state.eventUsers.isEmpty && state.loadingEvent) ...[
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
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return EventTabUsersUserListItem(
                    currentEventUser: state.getCurrentEventUser(),
                    eventUser: state.eventUsers[index],
                    event: state.event,
                  );
                },
                itemCount: state.eventUsers.length,
              ),
            ]
          ],
        );
      },
    );
  }
}
