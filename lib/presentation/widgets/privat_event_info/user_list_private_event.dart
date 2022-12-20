import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app_flutter/application/bloc/user/user_bloc.dart';
import 'package:social_media_app_flutter/domain/entities/groupchat/groupchat_user_entity.dart';
import 'package:social_media_app_flutter/domain/entities/user_entity.dart';
import 'package:social_media_app_flutter/presentation/router/router.gr.dart';
import 'package:social_media_app_flutter/presentation/widgets/user_list_tile.dart';

class UserListPrivateEvent extends StatelessWidget {
  final List<String> privateEventUserIdsThatWillBeThere;
  final List<String> privateEventUserIdsThatWillNotBeThere;
  final List<GroupchatUserEntity> invitedUsers;

  const UserListPrivateEvent({
    super.key,
    required this.privateEventUserIdsThatWillBeThere,
    required this.privateEventUserIdsThatWillNotBeThere,
    required this.invitedUsers,
  });

  @override
  Widget build(BuildContext context) {
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
              subtitle: "Angenommen",
              username: foundUser != null && foundUser.username != null
                  ? foundUser.username!
                  : "Kein Username",
              userId: privateEventUserIdThatWillBeThere,
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
              subtitle: "Abgelehnt",
              username: foundUser != null && foundUser.username != null
                  ? foundUser.username!
                  : "Kein Username",
              userId: privateEventUserIdThatWillNotBeThere,
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
              subtitle: "Eingeladen",
              username: foundUser != null && foundUser.username != null
                  ? foundUser.username!
                  : "Kein Username",
              userId: invitedUser.userId,
            ),
          );
        }

        return Column(children: widgetsToReturn);
      },
    );
  }
}
