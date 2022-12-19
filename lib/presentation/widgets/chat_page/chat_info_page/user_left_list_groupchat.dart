import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:social_media_app_flutter/application/bloc/user/user_bloc.dart';
import 'package:social_media_app_flutter/domain/entities/groupchat/groupchat_left_user_entity.dart';
import 'package:social_media_app_flutter/domain/entities/user_entity.dart';
import 'package:social_media_app_flutter/presentation/router/router.gr.dart';

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
                groupchatLeftUser.leftAt != null
                    ? DateFormat.yMd()
                        .add_jm()
                        .format(groupchatLeftUser.leftAt!)
                    : "Kein Datum",
                softWrap: true,
                overflow: TextOverflow.ellipsis,
              ),
              onTap: () {
                AutoRouter.of(context).root.push(
                      ProfilePageRoute(
                        userId: groupchatLeftUser.userId,
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
