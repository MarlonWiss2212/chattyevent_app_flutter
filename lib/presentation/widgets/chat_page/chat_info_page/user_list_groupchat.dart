import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app_flutter/application/bloc/user/user_bloc.dart';
import 'package:social_media_app_flutter/domain/entities/groupchat/groupchat_user_entity.dart';
import 'package:social_media_app_flutter/domain/entities/user_entity.dart';
import 'package:social_media_app_flutter/presentation/router/router.gr.dart';
import 'package:social_media_app_flutter/presentation/widgets/user_list_tile.dart';

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
            UserListTile(
              subtitle: groupchatUser.admin != null && groupchatUser.admin!
                  ? "Admin"
                  : "Nicht Admin",
              username: foundUser != null && foundUser.username != null
                  ? foundUser.username!
                  : "Kein Username",
              userId: groupchatUser.userId,
            ),
          );
        }
        return Column(children: widgetsToReturn);
      },
    );
  }
}
