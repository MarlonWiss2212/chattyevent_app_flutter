import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app_flutter/application/bloc/user/user_bloc.dart';
import 'package:social_media_app_flutter/domain/entities/groupchat/groupchat_user_entity.dart';
import 'package:social_media_app_flutter/domain/entities/user_entity.dart';
import 'package:social_media_app_flutter/presentation/router/router.gr.dart';

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
            ListTile(
              leading: CircleAvatar(
                backgroundColor:
                    Theme.of(context).colorScheme.secondaryContainer,
              ),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(5),
                ),
              ),
              title: Text(
                foundUser != null
                    ? foundUser.username ?? "Kein Username"
                    : "Kein Username",
              ),
              subtitle: Text(
                "Angenommen",
                softWrap: true,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              onTap: () {
                AutoRouter.of(context).root.push(
                      ProfilePageRoute(
                        userId: privateEventUserIdThatWillBeThere,
                      ),
                    );
              },
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
            ListTile(
              leading: CircleAvatar(
                backgroundColor:
                    Theme.of(context).colorScheme.secondaryContainer,
              ),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(5),
                ),
              ),
              title: Text(
                foundUser != null
                    ? foundUser.username ?? "Kein Username"
                    : "Kein Username",
              ),
              subtitle: const Text(
                "Abgelehnt",
                softWrap: true,
                style: TextStyle(
                  color: Colors.red,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              onTap: () {
                AutoRouter.of(context).root.push(
                      ProfilePageRoute(
                        userId: privateEventUserIdThatWillNotBeThere,
                      ),
                    );
              },
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
            ListTile(
              leading: CircleAvatar(
                backgroundColor:
                    Theme.of(context).colorScheme.secondaryContainer,
              ),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(5),
                ),
              ),
              title: Text(
                foundUser != null
                    ? foundUser.username ?? "Kein Username"
                    : "Kein Username",
              ),
              subtitle: const Text(
                "Eingeladen",
                softWrap: true,
                overflow: TextOverflow.ellipsis,
              ),
              onTap: () {
                AutoRouter.of(context).root.push(
                      ProfilePageRoute(
                        userId: invitedUser.userId,
                      ),
                    );
              },
            ),
          );
        }

        return Column(children: widgetsToReturn);
      },
    );
  }
}
