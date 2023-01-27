import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:social_media_app_flutter/application/bloc/chat/current_chat_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/user/user_cubit.dart';
import 'package:social_media_app_flutter/domain/entities/groupchat/groupchat_left_user_entity.dart';
import 'package:social_media_app_flutter/domain/entities/groupchat/groupchat_user_entity.dart';
import 'package:social_media_app_flutter/domain/entities/user_entity.dart';
import 'package:social_media_app_flutter/presentation/widgets/user_list_tile.dart';

class UserLeftListGroupchat extends StatelessWidget {
  final List<GroupchatLeftUserEntity> groupchatLeftUsers;
  final String groupchatId;
  final GroupchatUserEntity? currentGrouppchatUser;
  const UserLeftListGroupchat({
    super.key,
    required this.groupchatLeftUsers,
    required this.groupchatId,
    required this.currentGrouppchatUser,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
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
              profileImageLink: foundUser?.profileImageLink,
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
              longPress: currentGrouppchatUser != null &&
                      currentGrouppchatUser!.admin != null &&
                      currentGrouppchatUser!.admin == true &&
                      currentGrouppchatUser!.userId != groupchatLeftUser.userId
                  ? (userId) {
                      showMenu(
                        position: const RelativeRect.fromLTRB(
                            0, double.infinity, 0, 0),
                        context: context,
                        items: [
                          PopupMenuItem(
                            child: const Text("Hinzufügen"),
                            onTap: () =>
                                BlocProvider.of<CurrentChatCubit>(context)
                                    .addUserToChat(
                              groupchatId: groupchatId,
                              userIdToAdd: userId,
                            ),
                          ),
                        ],
                      );
                    }
                  : null,
            ),
          );
        }
        return Column(children: widgetsToReturn);
      },
    );
  }
}
