import 'package:chattyevent_app_flutter/core/enums/private_event/private_event_user/private_event_user_role_enum.dart';
import 'package:chattyevent_app_flutter/core/enums/private_event/private_event_user_status_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chattyevent_app_flutter/application/bloc/current_private_event/current_private_event_cubit.dart';
import 'package:chattyevent_app_flutter/domain/entities/private_event/private_event_entity.dart';
import 'package:chattyevent_app_flutter/domain/entities/private_event/private_event_user_entity.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/user_list/user_list_tile.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/screens/private_event_page/tab_users/tab_users_user_list/private_event_tab_users_icon_buttons_my_user_list_tile/accept_invite_icon_button.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/screens/private_event_page/tab_users/tab_users_user_list/private_event_tab_users_icon_buttons_my_user_list_tile/decline_invite_icon_button.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/screens/private_event_page/tab_users/tab_users_user_list/private_event_tab_users_icon_buttons_my_user_list_tile/neutral_invite_icon_button.dart';

class PrivateEventTabUsersUserListItem extends StatelessWidget {
  final PrivateEventUserEntity privateEventUser;
  final PrivateEventUserEntity? currentPrivatEventUser;
  final PrivateEventEntity privateEvent;
  const PrivateEventTabUsersUserListItem({
    super.key,
    required this.privateEventUser,
    required this.privateEvent,
    this.currentPrivatEventUser,
  });

  @override
  Widget build(BuildContext context) {
    Widget? trailingWidget;
    String subtitle = "gekicked";
    Color? subititleColor = Colors.red;

    if (privateEventUser.status == PrivateEventUserStatusEnum.accapted) {
      subititleColor = Colors.green;
      subtitle = "Angenommen";
      trailingWidget = currentPrivatEventUser != null &&
              privateEventUser.id == currentPrivatEventUser!.id
          ? Wrap(
              spacing: 8,
              children: [
                NeutralInviteIconButton(userId: currentPrivatEventUser!.id),
                DeclineInviteIconButton(userId: currentPrivatEventUser!.id),
              ],
            )
          : null;
    } else if (privateEventUser.status == PrivateEventUserStatusEnum.rejected) {
      subititleColor = Colors.red;
      subtitle = "Abgelehnt";
      trailingWidget = currentPrivatEventUser != null &&
              privateEventUser.id == currentPrivatEventUser!.id
          ? Wrap(
              spacing: 8,
              children: [
                AcceptInviteIconButton(userId: currentPrivatEventUser!.id),
                NeutralInviteIconButton(userId: currentPrivatEventUser!.id)
              ],
            )
          : null;
    } else if (privateEventUser.status == PrivateEventUserStatusEnum.invited) {
      subititleColor = null;
      subtitle = "Eingeladen";
      trailingWidget = currentPrivatEventUser != null &&
              privateEventUser.id == currentPrivatEventUser!.id
          ? Wrap(
              spacing: 8,
              children: [
                AcceptInviteIconButton(userId: currentPrivatEventUser!.id),
                DeclineInviteIconButton(userId: currentPrivatEventUser!.id)
              ],
            )
          : null;
    }

    if (privateEventUser.role == PrivateEventUserRoleEnum.organizer) {
      subtitle += " | Organisator";
    }

    return UserListTile(
      subtitle: Text(
        subtitle,
        style: TextStyle(color: subititleColor),
      ),
      user: privateEventUser,
      trailing: trailingWidget,
      items: [
        if (currentPrivatEventUser != null &&
                currentPrivatEventUser!.role ==
                    PrivateEventUserRoleEnum.organizer &&
                privateEvent.groupchatTo == null ||
            currentPrivatEventUser != null &&
                currentPrivatEventUser!.role ==
                    PrivateEventUserRoleEnum.organizer &&
                privateEvent.groupchatTo == "") ...{
          PopupMenuItem<void Function(void)>(
            child: const Text("Kicken"),
            onTap: () {
              BlocProvider.of<CurrentPrivateEventCubit>(context)
                  .deleteUserFromPrivateEventViaApi(
                userId: privateEventUser.id,
              );
            },
          ),
        },
        if (currentPrivatEventUser != null &&
            currentPrivatEventUser!.role ==
                PrivateEventUserRoleEnum.organizer &&
            privateEventUser.role != null &&
            currentPrivatEventUser?.id != privateEventUser.id) ...{
          PopupMenuItem<void Function(void)>(
            child: privateEventUser.role == PrivateEventUserRoleEnum.organizer
                ? const Text("Organisator status entfernen")
                : const Text("Zum Organisator machen"),
            onTap: () {
              BlocProvider.of<CurrentPrivateEventCubit>(context)
                  .updatePrivateEventUser(
                userId: privateEventUser.id,
                role:
                    privateEventUser.role == PrivateEventUserRoleEnum.organizer
                        ? PrivateEventUserRoleEnum.member
                        : PrivateEventUserRoleEnum.organizer,
              );
            },
          ),
        },
      ],
    );
  }
}
