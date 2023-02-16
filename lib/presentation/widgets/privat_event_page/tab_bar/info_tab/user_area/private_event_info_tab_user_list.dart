import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:skeletons/skeletons.dart';
import 'package:social_media_app_flutter/application/bloc/auth/auth_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/private_event/current_private_event_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/user/user_cubit.dart';
import 'package:social_media_app_flutter/domain/entities/groupchat/groupchat_user_entity.dart';
import 'package:social_media_app_flutter/presentation/widgets/privat_event_page/tab_bar/info_tab/icon_buttons_my_user_list_tile/accept_invite_icon_button.dart';
import 'package:social_media_app_flutter/presentation/widgets/privat_event_page/tab_bar/info_tab/icon_buttons_my_user_list_tile/decline_invite_icon_button.dart';
import 'package:social_media_app_flutter/presentation/widgets/privat_event_page/tab_bar/info_tab/icon_buttons_my_user_list_tile/neutral_invite_icon_button.dart';
import 'package:social_media_app_flutter/presentation/widgets/user_list/user_list_tile.dart';

class PrivateEventInfoTabUserList extends StatelessWidget {
  final CurrentPrivateEventState privateEventState;
  final List<GroupchatUserEntity>? invitedUsers;

  const PrivateEventInfoTabUserList({
    super.key,
    required this.privateEventState,
    this.invitedUsers,
  });

  @override
  Widget build(BuildContext context) {
    final currentUserId = Jwt.parseJwt(
        (BlocProvider.of<AuthCubit>(context).state as AuthLoaded).token)["sub"];
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        List<Widget> widgetsToReturn = [];

        for (final privateEventUser in privateEventState.privateEventUsers) {
          Widget? trailingWidget;
          String subtitle = "gekicked";
          Color? subititleColor = Colors.red;
          if (privateEventUser.privateEventUser.status == "accapted") {
            subititleColor = Colors.green;
            subtitle = "Angenommen";
            trailingWidget = privateEventUser.user.id == currentUserId
                ? Wrap(
                    spacing: 8,
                    children: [
                      NeutralInviteIconButton(
                        privateEventId: privateEventState.privateEvent.id,
                      ),
                      DeclineInviteIconButton(
                        privateEventId: privateEventState.privateEvent.id,
                      ),
                    ],
                  )
                : null;
          } else if (privateEventUser.privateEventUser.status == "rejected") {
            subititleColor = Colors.red;
            subtitle = "Abgelehnt";
            trailingWidget = privateEventUser.user.id == currentUserId
                ? Wrap(
                    spacing: 8,
                    children: [
                      AcceptInviteIconButton(
                        privateEventId: privateEventState.privateEvent.id,
                      ),
                      NeutralInviteIconButton(
                        privateEventId: privateEventState.privateEvent.id,
                      )
                    ],
                  )
                : null;
          } else if (privateEventUser.privateEventUser.status == "invited") {
            subititleColor = null;
            subtitle = "Eingeladen";
            trailingWidget = privateEventUser.user.id == currentUserId
                ? Wrap(
                    spacing: 8,
                    children: [
                      AcceptInviteIconButton(
                        privateEventId: privateEventState.privateEvent.id,
                      ),
                      DeclineInviteIconButton(
                        privateEventId: privateEventState.privateEvent.id,
                      )
                    ],
                  )
                : null;
          }

          widgetsToReturn.add(
            UserListTile(
              profileImageLink: privateEventUser.user.profileImageLink,
              subtitle: Text(
                subtitle,
                style: TextStyle(color: subititleColor),
              ),
              username: privateEventUser.getUsername(),
              userId: privateEventUser.user.id,
              trailing: trailingWidget,
            ),
          );
        }

        if (privateEventState.privateEventUsers.isEmpty &&
            privateEventState.loadingPrivateEvent) {
          Widget skeleton = SkeletonListTile(
            padding: const EdgeInsets.all(8),
            hasSubtitle: true,
            titleStyle: const SkeletonLineStyle(width: 100, height: 22),
            subtitleStyle:
                const SkeletonLineStyle(width: double.infinity, height: 16),
            leadingStyle: const SkeletonAvatarStyle(
              shape: BoxShape.circle,
            ),
          );
          widgetsToReturn.add(skeleton);
          widgetsToReturn.add(skeleton);
          widgetsToReturn.add(skeleton);
        }

        return Column(children: widgetsToReturn);
      },
    );
  }
}
