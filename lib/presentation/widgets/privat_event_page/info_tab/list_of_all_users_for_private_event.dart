import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app_flutter/application/bloc/auth/auth_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/user/user_cubit.dart';
import 'package:social_media_app_flutter/domain/entities/groupchat/groupchat_user_entity.dart';
import 'package:social_media_app_flutter/domain/entities/user_entity.dart';
import 'package:social_media_app_flutter/presentation/widgets/privat_event_page/info_tab/icon_buttons_my_user_list_tile/accept_invite_icon_button.dart';
import 'package:social_media_app_flutter/presentation/widgets/privat_event_page/info_tab/icon_buttons_my_user_list_tile/decline_invite_icon_button.dart';
import 'package:social_media_app_flutter/presentation/widgets/privat_event_page/info_tab/icon_buttons_my_user_list_tile/neutral_invite_icon_button.dart';
import 'package:social_media_app_flutter/presentation/widgets/user_list_tile.dart';

class ListOfAllUsersForPrivateEvent extends StatelessWidget {
  final String privateEventId;
  final List<String> privateEventUserIdsThatWillBeThere;
  final List<String> privateEventUserIdsThatWillNotBeThere;
  final List<GroupchatUserEntity> invitedUsers;

  const ListOfAllUsersForPrivateEvent({
    super.key,
    required this.privateEventUserIdsThatWillBeThere,
    required this.privateEventUserIdsThatWillNotBeThere,
    required this.privateEventId,
    required this.invitedUsers,
  });

  @override
  Widget build(BuildContext context) {
    final authState =
        BlocProvider.of<AuthCubit>(context).state as AuthStateLoaded;

    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        List<Widget> widgetsToReturn = [];

        // users that will be there
        for (final privateEventUserIdThatWillBeThere
            in privateEventUserIdsThatWillBeThere) {
          UserEntity? foundUser;
          if (state is UserStateLoaded) {
            for (final user in state.users) {
              if (user.id == privateEventUserIdThatWillBeThere) {
                foundUser = user;
                break;
              }
            }
          }
          widgetsToReturn.add(
            UserListTile(
              profileImageLink: foundUser?.profileImageLink,
              subtitle: const Text(
                "Angenommen",
                style: TextStyle(color: Colors.green),
              ),
              username: foundUser != null && foundUser.username != null
                  ? foundUser.username!
                  : "Kein Username",
              userId: privateEventUserIdThatWillBeThere,
              trailing: privateEventUserIdThatWillBeThere ==
                      authState.userAndToken.user.id
                  ? Wrap(
                      spacing: 8,
                      children: [
                        DeclineInviteIconButton(privateEventId: privateEventId),
                        NeutralInviteIconButton(privateEventId: privateEventId)
                      ],
                    )
                  : null,
            ),
          );
        }

        // users that will not be there
        for (final privateEventUserIdThatWillNotBeThere
            in privateEventUserIdsThatWillNotBeThere) {
          UserEntity? foundUser;
          if (state is UserStateLoaded) {
            for (final user in state.users) {
              if (user.id == privateEventUserIdThatWillNotBeThere) {
                foundUser = user;
                break;
              }
            }
          }
          widgetsToReturn.add(
            UserListTile(
              profileImageLink: foundUser?.profileImageLink,
              subtitle: const Text(
                "Abgelehnt",
                style: TextStyle(color: Colors.red),
              ),
              username: foundUser != null && foundUser.username != null
                  ? foundUser.username!
                  : "Kein Username",
              userId: privateEventUserIdThatWillNotBeThere,
              trailing: privateEventUserIdThatWillNotBeThere ==
                      authState.userAndToken.user.id
                  ? Wrap(
                      spacing: 8,
                      children: [
                        AcceptInviteIconButton(privateEventId: privateEventId),
                        NeutralInviteIconButton(privateEventId: privateEventId)
                      ],
                    )
                  : null,
            ),
          );
        }

        // invited users
        for (final invitedUser in invitedUsers) {
          UserEntity? foundUser;
          if (state is UserStateLoaded) {
            for (final user in state.users) {
              if (user.id == invitedUser.userId) {
                foundUser = user;
                break;
              }
            }
          }

          widgetsToReturn.add(
            UserListTile(
              profileImageLink: foundUser?.profileImageLink,
              subtitle: const Text("Eingeladen"),
              username: foundUser != null && foundUser.username != null
                  ? foundUser.username!
                  : "Kein Username",
              userId: invitedUser.userId,
              trailing: invitedUser.userId == authState.userAndToken.user.id
                  ? Wrap(
                      spacing: 8,
                      children: [
                        AcceptInviteIconButton(privateEventId: privateEventId),
                        DeclineInviteIconButton(privateEventId: privateEventId)
                      ],
                    )
                  : null,
            ),
          );
        }

        return Column(children: widgetsToReturn);
      },
    );
  }
}
