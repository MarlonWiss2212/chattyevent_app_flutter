import 'package:chattyevent_app_flutter/core/enums/event/event_user/event_user_role_enum.dart';
import 'package:chattyevent_app_flutter/core/enums/event/event_user/event_user_status_enum.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chattyevent_app_flutter/application/bloc/current_event/current_event_cubit.dart';
import 'package:chattyevent_app_flutter/domain/entities/event/event_entity.dart';
import 'package:chattyevent_app_flutter/domain/entities/event/event_user_entity.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/user_list/user_list_tile.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/screens/event_page/tab_users/tab_users_user_list/event_tab_users_icon_buttons_my_user_list_tile/accept_invite_icon_button.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/screens/event_page/tab_users/tab_users_user_list/event_tab_users_icon_buttons_my_user_list_tile/decline_invite_icon_button.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/screens/event_page/tab_users/tab_users_user_list/event_tab_users_icon_buttons_my_user_list_tile/neutral_invite_icon_button.dart';

class EventTabUsersUserListItem extends StatelessWidget {
  final EventUserEntity eventUser;
  final EventUserEntity? currentEventUser;
  final EventEntity event;
  const EventTabUsersUserListItem({
    super.key,
    required this.eventUser,
    required this.event,
    this.currentEventUser,
  });

  @override
  Widget build(BuildContext context) {
    Widget? trailingWidget;
    String subtitle = "eventPage.tabs.userListTab.userList.kickedText".tr();
    Color? subititleColor = Colors.red;

    if (eventUser.status == EventUserStatusEnum.accepted) {
      subititleColor = Colors.green;
      subtitle = "eventPage.tabs.userListTab.userList.acceptedText".tr();
      trailingWidget =
          currentEventUser != null && eventUser.id == currentEventUser!.id
              ? Wrap(
                  spacing: 8,
                  children: [
                    NeutralInviteIconButton(userId: currentEventUser!.id),
                    DeclineInviteIconButton(userId: currentEventUser!.id),
                  ],
                )
              : null;
    } else if (eventUser.status == EventUserStatusEnum.rejected) {
      subititleColor = Colors.red;
      subtitle = "eventPage.tabs.userListTab.userList.rejectedText".tr();
      trailingWidget =
          currentEventUser != null && eventUser.id == currentEventUser!.id
              ? Wrap(
                  spacing: 8,
                  children: [
                    AcceptInviteIconButton(userId: currentEventUser!.id),
                    NeutralInviteIconButton(userId: currentEventUser!.id)
                  ],
                )
              : null;
    } else if (eventUser.status == EventUserStatusEnum.unknown) {
      subititleColor = null;
      subtitle = "eventPage.tabs.userListTab.userList.unknownText".tr();
      trailingWidget =
          currentEventUser != null && eventUser.id == currentEventUser!.id
              ? Wrap(
                  spacing: 8,
                  children: [
                    AcceptInviteIconButton(userId: currentEventUser!.id),
                    DeclineInviteIconButton(userId: currentEventUser!.id)
                  ],
                )
              : null;
    }

    if (eventUser.role == EventUserRoleEnum.organizer) {
      subtitle +=
          "eventPage.tabs.userListTab.userList.statusPlusOrganizerText".tr();
    }

    return UserListTile(
      subtitle: Text(
        subtitle,
        style: TextStyle(color: subititleColor),
      ),
      user: eventUser,
      trailing: trailingWidget,
      items: [
        if (currentEventUser != null &&
                currentEventUser!.role == EventUserRoleEnum.organizer &&
                event.privateEventData?.groupchatTo == null ||
            currentEventUser != null &&
                currentEventUser!.role == EventUserRoleEnum.organizer &&
                event.privateEventData?.groupchatTo == "") ...{
          PopupMenuItem<void Function(void)>(
            child: const Text("general.kickText").tr(),
            onTap: () {
              BlocProvider.of<CurrentEventCubit>(context)
                  .deleteUserFromEventViaApi(
                userId: eventUser.id,
              );
            },
          ),
        },
        if (currentEventUser != null &&
            currentEventUser!.role == EventUserRoleEnum.organizer &&
            eventUser.role != null &&
            currentEventUser?.id != eventUser.id) ...{
          PopupMenuItem<void Function(void)>(
            child: eventUser.role == EventUserRoleEnum.organizer
                ? const Text(
                        "eventPage.tabs.userListTab.userList.removeOrganizerStatus")
                    .tr()
                : const Text(
                        "eventPage.tabs.userListTab.userList.makeOrganizer")
                    .tr(),
            onTap: () {
              BlocProvider.of<CurrentEventCubit>(context).updateEventUser(
                userId: eventUser.id,
                role: eventUser.role == EventUserRoleEnum.organizer
                    ? EventUserRoleEnum.member
                    : EventUserRoleEnum.organizer,
              );
            },
          ),
        },
      ],
    );
  }
}
