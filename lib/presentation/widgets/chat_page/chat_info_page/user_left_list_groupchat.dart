import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:social_media_app_flutter/application/bloc/user/user_bloc.dart';
import 'package:social_media_app_flutter/domain/entities/groupchat/groupchat_left_user_entity.dart';
import 'package:social_media_app_flutter/domain/entities/user_entity.dart';
import 'package:social_media_app_flutter/presentation/widgets/user_list_tile.dart';

class UserLeftListGroupchat extends StatelessWidget {
  final List<GroupchatLeftUserEntity> groupchatLeftUsers;
  const UserLeftListGroupchat({super.key, required this.groupchatLeftUsers});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        List<Widget> widgetsToReturn = [];
        for (final groupchatLeftUser in groupchatLeftUsers) {
          UserEntity? foundUser;
          if (state is UserStateLoaded) {
            for (final user in state.users) {
              if (user.id == groupchatLeftUser.userId) {
                foundUser = user;
                break;
              }
            }
          }
          widgetsToReturn.add(
            UserListTile(
              subtitle: groupchatLeftUser.leftAt != null
                  ? Text(
                      DateFormat.yMd()
                          .add_jm()
                          .format(groupchatLeftUser.leftAt!),
                      overflow: TextOverflow.ellipsis,
                    )
                  : const Text(
                      "Kein Datum",
                      overflow: TextOverflow.ellipsis,
                    ),
              username: foundUser != null && foundUser.username != null
                  ? foundUser.username!
                  : "Kein Username",
              userId: groupchatLeftUser.userId,
            ),
          );
        }
        return Column(children: widgetsToReturn);
      },
    );
  }
}
