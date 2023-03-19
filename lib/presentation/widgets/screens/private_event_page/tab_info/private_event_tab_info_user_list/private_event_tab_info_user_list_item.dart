import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app_flutter/application/bloc/private_event/current_private_event_cubit.dart';
import 'package:social_media_app_flutter/domain/entities/private_event/user_with_private_event_user_data.dart';
import 'package:social_media_app_flutter/presentation/widgets/screens/private_event_page/tab_info/private_event_tab_info_user_list/private_event_tab_info_user_list_item_icon_buttons_my_user_list_tile/accept_invite_icon_button.dart';
import 'package:social_media_app_flutter/presentation/widgets/screens/private_event_page/tab_info/private_event_tab_info_user_list/private_event_tab_info_user_list_item_icon_buttons_my_user_list_tile/decline_invite_icon_button.dart';
import 'package:social_media_app_flutter/presentation/widgets/screens/private_event_page/tab_info/private_event_tab_info_user_list/private_event_tab_info_user_list_item_icon_buttons_my_user_list_tile/neutral_invite_icon_button.dart';
import 'package:social_media_app_flutter/presentation/widgets/user_list/user_list_tile.dart';

class PrivateEventTabInfoUserListItem extends StatelessWidget {
  final UserWithPrivateEventUserData privateEventUser;
  final UserWithPrivateEventUserData? currentPrivatEventUser;

  const PrivateEventTabInfoUserListItem({
    super.key,
    required this.privateEventUser,
    this.currentPrivatEventUser,
  });

  @override
  Widget build(BuildContext context) {
    Widget? trailingWidget;
    String subtitle = "gekicked";
    Color? subititleColor = Colors.red;

    if (privateEventUser.privateEventUser.status == "accepted") {
      subititleColor = Colors.green;
      subtitle = "Angenommen";
      trailingWidget = currentPrivatEventUser != null &&
              privateEventUser.user.id == currentPrivatEventUser!.user.id
          ? Wrap(
              spacing: 8,
              children: [
                NeutralInviteIconButton(
                    userId: currentPrivatEventUser!.user.id),
                DeclineInviteIconButton(
                    userId: currentPrivatEventUser!.user.id),
              ],
            )
          : null;
    } else if (privateEventUser.privateEventUser.status == "rejected") {
      subititleColor = Colors.red;
      subtitle = "Abgelehnt";
      trailingWidget = currentPrivatEventUser != null &&
              privateEventUser.user.id == currentPrivatEventUser!.user.id
          ? Wrap(
              spacing: 8,
              children: [
                AcceptInviteIconButton(userId: currentPrivatEventUser!.user.id),
                NeutralInviteIconButton(userId: currentPrivatEventUser!.user.id)
              ],
            )
          : null;
    } else if (privateEventUser.privateEventUser.status == "invited") {
      subititleColor = null;
      subtitle = "Eingeladen";
      trailingWidget = currentPrivatEventUser != null &&
              privateEventUser.user.id == currentPrivatEventUser!.user.id
          ? Wrap(
              spacing: 8,
              children: [
                AcceptInviteIconButton(userId: currentPrivatEventUser!.user.id),
                DeclineInviteIconButton(userId: currentPrivatEventUser!.user.id)
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
      user: privateEventUser.user,
      customTitle: privateEventUser.getUsername(),
      trailing: trailingWidget,
      items: [
        if (currentPrivatEventUser != null &&
            currentPrivatEventUser!.privateEventUser.organizer == true &&
            privateEventUser.privateEventUser.organizer != null &&
            currentPrivatEventUser?.user.id != privateEventUser.user.id) ...{
          PopupMenuItem<void Function(void)>(
            child: privateEventUser.privateEventUser.organizer == true
                ? const Text("Organisator status entfernen")
                : const Text("Zum Organisator machen"),
            onTap: () {
              BlocProvider.of<CurrentPrivateEventCubit>(context)
                  .updatePrivateEventUser(
                userId: privateEventUser.user.id,
                organizer: !privateEventUser.privateEventUser.organizer!,
              );
            },
          ),
        },
        if (currentPrivatEventUser != null &&
            currentPrivatEventUser!.user.id == privateEventUser.user.id &&
            privateEventUser.privateEventUser.organizer == true) ...{
          PopupMenuItem<void Function(void)>(
            child: const Text("Organisator status entfernen"),
            onTap: () {
              BlocProvider.of<CurrentPrivateEventCubit>(context)
                  .updatePrivateEventUser(
                userId: privateEventUser.user.id,
                organizer: false,
              );
            },
          ),
        }
      ],
    );
  }
}
