import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app_flutter/application/bloc/private_event/current_private_event_cubit.dart';
import 'package:social_media_app_flutter/domain/entities/groupchat/groupchat_entity.dart';
import 'package:social_media_app_flutter/domain/entities/groupchat/groupchat_user_entity.dart';
import 'package:social_media_app_flutter/domain/entities/private_event/private_event_entity.dart';
import 'package:social_media_app_flutter/domain/entities/private_event/user_with_private_event_user_data.dart';
import 'package:social_media_app_flutter/domain/entities/user/user_entity.dart';
import 'package:social_media_app_flutter/presentation/widgets/general/user_list/user_list_tile.dart';
import 'package:social_media_app_flutter/presentation/widgets/screens/private_event_page/tab_users/tab_users_user_list/private_event_tab_users_icon_buttons_my_user_list_tile/accept_invite_icon_button.dart';
import 'package:social_media_app_flutter/presentation/widgets/screens/private_event_page/tab_users/tab_users_user_list/private_event_tab_users_icon_buttons_my_user_list_tile/decline_invite_icon_button.dart';
import 'package:social_media_app_flutter/presentation/widgets/screens/private_event_page/tab_users/tab_users_user_list/private_event_tab_users_icon_buttons_my_user_list_tile/neutral_invite_icon_button.dart';

class PrivateEventTabUsersUserListItem extends StatelessWidget {
  final UserWithPrivateEventUserData privateEventUser;
  final UserWithPrivateEventUserData? currentPrivatEventUser;
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

    if (privateEventUser.privateEventUser.status == "ACCEPTED") {
      subititleColor = Colors.green;
      subtitle = "Angenommen";
      trailingWidget = currentPrivatEventUser != null &&
              privateEventUser.groupchatUser?.id ==
                  currentPrivatEventUser!.groupchatUser?.id
          ? Wrap(
              spacing: 8,
              children: [
                NeutralInviteIconButton(
                    userId: currentPrivatEventUser!.groupchatUser?.id ?? ""),
                DeclineInviteIconButton(
                    userId: currentPrivatEventUser!.groupchatUser?.id ?? ""),
              ],
            )
          : null;
    } else if (privateEventUser.privateEventUser.status == "REJECTED") {
      subititleColor = Colors.red;
      subtitle = "Abgelehnt";
      trailingWidget = currentPrivatEventUser != null &&
              privateEventUser.groupchatUser?.id ==
                  currentPrivatEventUser!.groupchatUser?.id
          ? Wrap(
              spacing: 8,
              children: [
                AcceptInviteIconButton(
                    userId: currentPrivatEventUser!.groupchatUser?.id ?? ""),
                NeutralInviteIconButton(
                    userId: currentPrivatEventUser!.groupchatUser?.id ?? "")
              ],
            )
          : null;
    } else if (privateEventUser.privateEventUser.status == "INVITED") {
      subititleColor = null;
      subtitle = "Eingeladen";
      trailingWidget = currentPrivatEventUser != null &&
              privateEventUser.groupchatUser?.id ==
                  currentPrivatEventUser!.groupchatUser?.id
          ? Wrap(
              spacing: 8,
              children: [
                AcceptInviteIconButton(
                    userId: currentPrivatEventUser!.groupchatUser?.id ?? ""),
                DeclineInviteIconButton(
                    userId: currentPrivatEventUser!.groupchatUser?.id ?? "")
              ],
            )
          : null;
    }

    if (privateEventUser.privateEventUser.organizer == true) {
      subtitle += " | Organisator";
    }

    return UserListTile(
      subtitle: Text(
        subtitle,
        style: TextStyle(color: subititleColor),
      ),
      user: privateEventUser.groupchatUser ??
          UserEntity(
            id: privateEventUser.privateEventUser.userId ?? "",
            authId: "",
          ),
      customTitle: privateEventUser.getUsername(),
      trailing: trailingWidget,
      items: [
        if (currentPrivatEventUser != null &&
                currentPrivatEventUser!.privateEventUser.organizer == true &&
                privateEvent.groupchatTo == null ||
            currentPrivatEventUser != null &&
                currentPrivatEventUser!.privateEventUser.organizer == true &&
                privateEvent.groupchatTo == "") ...{
          PopupMenuItem<void Function(void)>(
            child: const Text("Kicken"),
            onTap: () {
              BlocProvider.of<CurrentPrivateEventCubit>(context)
                  .deleteUserFromPrivateEventViaApi(
                userId: privateEventUser.groupchatUser?.id ??
                    privateEventUser.privateEventUser.userId ??
                    "",
              );
            },
          ),
        },
        if (currentPrivatEventUser != null &&
            currentPrivatEventUser!.privateEventUser.organizer == true &&
            privateEventUser.privateEventUser.organizer != null &&
            currentPrivatEventUser?.groupchatUser?.id !=
                privateEventUser.groupchatUser?.id) ...{
          PopupMenuItem<void Function(void)>(
            child: privateEventUser.privateEventUser.organizer == true
                ? const Text("Organisator status entfernen")
                : const Text("Zum Organisator machen"),
            onTap: () {
              BlocProvider.of<CurrentPrivateEventCubit>(context)
                  .updatePrivateEventUser(
                userId: privateEventUser.groupchatUser?.id ??
                    privateEventUser.privateEventUser.userId ??
                    "",
                organizer: !privateEventUser.privateEventUser.organizer!,
              );
            },
          ),
        },
      ],
    );
  }
}
