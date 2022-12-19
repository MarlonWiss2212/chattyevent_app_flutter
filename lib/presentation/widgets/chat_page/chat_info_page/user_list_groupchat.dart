import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app_flutter/application/bloc/user/user_bloc.dart';
import 'package:social_media_app_flutter/domain/entities/groupchat/groupchat_user_entity.dart';
import 'package:social_media_app_flutter/domain/entities/user_entity.dart';
import 'package:social_media_app_flutter/presentation/router/router.gr.dart';

class UserListGroupchat extends StatelessWidget {
  final List<GroupchatUserEntity> groupchatUsers;
  const UserListGroupchat({super.key, required this.groupchatUsers});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        List<Widget> widgetsToReturn = [];
        for (final groupchatUser in groupchatUsers) {
          UserEntity? foundUser;
          if (state is UserStateLoaded) {
            for (final user in state.users) {
              if (user.id == groupchatUser.userId) {
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
                groupchatUser.admin != null && groupchatUser.admin!
                    ? "Admin"
                    : "Nicht Admin",
                softWrap: true,
                style: TextStyle(
                  color: groupchatUser.admin != null && groupchatUser.admin!
                      ? Theme.of(context).colorScheme.primary
                      : null,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              onTap: () {
                AutoRouter.of(context).root.push(
                      ProfilePageRoute(
                        userId: groupchatUser.userId,
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
