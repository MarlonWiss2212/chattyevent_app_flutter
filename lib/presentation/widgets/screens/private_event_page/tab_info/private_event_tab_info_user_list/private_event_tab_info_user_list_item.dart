import 'package:flutter/material.dart';
import 'package:social_media_app_flutter/domain/entities/private_event/user_with_private_event_user_data.dart';
import 'package:social_media_app_flutter/presentation/widgets/screens/private_event_page/tab_info/private_event_tab_info_user_list/private_event_tab_info_user_list_item_icon_buttons_my_user_list_tile/accept_invite_icon_button.dart';
import 'package:social_media_app_flutter/presentation/widgets/screens/private_event_page/tab_info/private_event_tab_info_user_list/private_event_tab_info_user_list_item_icon_buttons_my_user_list_tile/decline_invite_icon_button.dart';
import 'package:social_media_app_flutter/presentation/widgets/screens/private_event_page/tab_info/private_event_tab_info_user_list/private_event_tab_info_user_list_item_icon_buttons_my_user_list_tile/neutral_invite_icon_button.dart';
import 'package:social_media_app_flutter/presentation/widgets/user_list/user_list_tile.dart';

class PrivateEventTabInfoUserListItem extends StatelessWidget {
  final UserWithPrivateEventUserData privateEventUser;
  final String currentUserId;

  const PrivateEventTabInfoUserListItem({
    super.key,
    required this.currentUserId,
    required this.privateEventUser,
  });

  @override
  Widget build(BuildContext context) {
    Widget? trailingWidget;
    String subtitle = "gekicked";
    Color? subititleColor = Colors.red;

    if (privateEventUser.privateEventUser.status == "accapted") {
      subititleColor = Colors.green;
      subtitle = "Angenommen";
      trailingWidget = privateEventUser.user.id == currentUserId
          ? Wrap(
              spacing: 8,
              children: const [
                NeutralInviteIconButton(),
                DeclineInviteIconButton(),
              ],
            )
          : null;
    } else if (privateEventUser.privateEventUser.status == "rejected") {
      subititleColor = Colors.red;
      subtitle = "Abgelehnt";
      trailingWidget = privateEventUser.user.id == currentUserId
          ? Wrap(
              spacing: 8,
              children: const [
                AcceptInviteIconButton(),
                NeutralInviteIconButton()
              ],
            )
          : null;
    } else if (privateEventUser.privateEventUser.status == "invited") {
      subititleColor = null;
      subtitle = "Eingeladen";
      trailingWidget = privateEventUser.user.id == currentUserId
          ? Wrap(
              spacing: 8,
              children: const [
                AcceptInviteIconButton(),
                DeclineInviteIconButton()
              ],
            )
          : null;
    }

    return UserListTile(
      profileImageLink: privateEventUser.user.profileImageLink,
      subtitle: Text(
        subtitle,
        style: TextStyle(color: subititleColor),
      ),
      username: privateEventUser.getUsername(),
      userId: privateEventUser.user.id,
      trailing: trailingWidget,
    );
  }
}
