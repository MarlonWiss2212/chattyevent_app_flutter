import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app_flutter/application/bloc/chat/chat_bloc.dart';
import 'package:social_media_app_flutter/application/bloc/user/user_bloc.dart';
import 'package:social_media_app_flutter/domain/entities/groupchat/groupchat_user_entity.dart';
import 'package:social_media_app_flutter/domain/entities/user_entity.dart';
import 'package:social_media_app_flutter/presentation/widgets/user_list_tile.dart';

class UserListGroupchat extends StatelessWidget {
  final List<GroupchatUserEntity> groupchatUsers;
  final String groupchatId;
  final String currentUserId;

  const UserListGroupchat({
    super.key,
    required this.groupchatUsers,
    required this.groupchatId,
    required this.currentUserId,
  });

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
                  ? Text(
                      "Admin",
                      softWrap: true,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      overflow: TextOverflow.ellipsis,
                    )
                  : const Text(
                      "Nicht Admin",
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                    ),
              username: foundUser != null && foundUser.username != null
                  ? foundUser.username!
                  : "Kein Username",
              userId: groupchatUser.userId,
              longPress: (userId) {
                if (currentUserId == userId) {
                  return;
                }

                showMenu(
                  position:
                      const RelativeRect.fromLTRB(0, double.infinity, 0, 0),
                  context: context,
                  items: [
                    PopupMenuItem(
                      child: const Text("Kicken"),
                      onTap: () => BlocProvider.of<ChatBloc>(context).add(
                        DeleteUserFromChatEvent(
                          groupchatId: groupchatId,
                          userIdToDelete: userId,
                        ),
                      ),
                    )
                  ],
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
