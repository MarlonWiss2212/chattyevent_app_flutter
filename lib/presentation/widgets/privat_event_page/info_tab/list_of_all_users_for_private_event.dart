import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:social_media_app_flutter/application/bloc/auth/auth_bloc.dart';
import 'package:social_media_app_flutter/application/bloc/user/user_bloc.dart';
import 'package:social_media_app_flutter/domain/entities/groupchat/groupchat_user_entity.dart';
import 'package:social_media_app_flutter/domain/entities/user_entity.dart';
import 'package:social_media_app_flutter/presentation/widgets/user_list_tile.dart';

class ListOfAllUsersForPrivateEvent extends StatelessWidget {
  final List<String> privateEventUserIdsThatWillBeThere;
  final List<String> privateEventUserIdsThatWillNotBeThere;
  final List<GroupchatUserEntity> invitedUsers;

  const ListOfAllUsersForPrivateEvent({
    super.key,
    required this.privateEventUserIdsThatWillBeThere,
    required this.privateEventUserIdsThatWillNotBeThere,
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
                  ? IconButton(
                      icon: const Icon(
                        Icons.close,
                        color: Colors.red,
                      ),
                      onPressed: () {
                        print(2);
                      }, // user should leave private event
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
                  ? IconButton(
                      icon: const Icon(
                        Icons.done,
                        color: Colors.green,
                      ),
                      onPressed: () {
                        print(1);
                      }, // user should join private event
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
                  ? //Row(
                  //mainAxisSize: MainAxisSize.min,
                  //children: [
                  IconButton(
                      icon: const Icon(
                        Icons.done,
                        color: Colors.green,
                      ),
                      onPressed: () {
                        print(1);
                      }, // user should join private event
                    ) //,
                  //IconButton(
                  //icon: const Icon(
                  //     Icons.close,
                  //       color: Colors.red,
                  //     ),
                  //    onPressed: () {
                  //      print(2);
                  //     }, // user should leave private event
                  ///    ),
                  //  ],
                  // )
                  : null,
            ),
          );
        }

        return Column(children: widgetsToReturn);
      },
    );
  }
}
