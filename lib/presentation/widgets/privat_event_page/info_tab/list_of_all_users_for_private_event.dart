import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:social_media_app_flutter/application/bloc/auth/auth_bloc.dart';
import 'package:social_media_app_flutter/application/bloc/user/user_bloc.dart';
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
    String currentUserId = "";

    final authState = BlocProvider.of<AuthBloc>(context).state;

    if (authState is AuthStateLoaded) {
      currentUserId = Jwt.parseJwt(authState.token)["sub"];
    }

    return BlocBuilder<UserBloc, UserState>(
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
              subtitle: const Text(
                "Angenommen",
                style: TextStyle(color: Colors.green),
              ),
              username: foundUser != null && foundUser.username != null
                  ? foundUser.username!
                  : "Kein Username",
              userId: privateEventUserIdThatWillBeThere,
              trailing: privateEventUserIdThatWillBeThere == currentUserId
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
              subtitle: const Text(
                "Abgelehnt",
                style: TextStyle(color: Colors.red),
              ),
              username: foundUser != null && foundUser.username != null
                  ? foundUser.username!
                  : "Kein Username",
              userId: privateEventUserIdThatWillNotBeThere,
              trailing: privateEventUserIdThatWillNotBeThere == currentUserId
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
              subtitle: const Text("Eingeladen"),
              username: foundUser != null && foundUser.username != null
                  ? foundUser.username!
                  : "Kein Username",
              userId: invitedUser.userId,
              trailing: invitedUser.userId == currentUserId
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
