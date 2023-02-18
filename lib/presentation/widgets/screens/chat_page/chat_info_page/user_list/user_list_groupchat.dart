import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app_flutter/application/bloc/chat/current_chat_cubit.dart';
import 'package:social_media_app_flutter/core/dto/groupchat/create_groupchat_left_user_dto.dart';
import 'package:social_media_app_flutter/domain/entities/groupchat/user_with_groupchat_user_data.dart';
import 'package:social_media_app_flutter/presentation/widgets/user_list/user_list_tile.dart';

class UserListGroupchat extends StatelessWidget {
  final UserWithGroupchatUserData currentUserWithGroupchatUserData;
  final CurrentChatState chatState;

  const UserListGroupchat({
    super.key,
    required this.chatState,
    required this.currentUserWithGroupchatUserData,
  });

  @override
  Widget build(BuildContext context) {
    List<Widget> widgetsToReturn = [];

    for (final userWithGroupchatUserData
        in chatState.usersWithGroupchatUserData) {
      widgetsToReturn.add(
        UserListTile(
          profileImageLink: userWithGroupchatUserData.profileImageLink,
          subtitle: userWithGroupchatUserData.admin != null &&
                  userWithGroupchatUserData.admin! == true
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
          username: userWithGroupchatUserData.usernameForChat != null
              ? userWithGroupchatUserData.usernameForChat!
              : userWithGroupchatUserData.username != null
                  ? userWithGroupchatUserData.username!
                  : "Kein Username",
          userId: userWithGroupchatUserData.id,
          longPress: currentUserWithGroupchatUserData.admin != null &&
                  currentUserWithGroupchatUserData.admin == true &&
                  currentUserWithGroupchatUserData.id !=
                      userWithGroupchatUserData.id
              ? (userId) {
                  showMenu(
                    position:
                        const RelativeRect.fromLTRB(0, double.infinity, 0, 0),
                    context: context,
                    items: [
                      PopupMenuItem(
                        child: const Text("Kicken"),
                        onTap: () => BlocProvider.of<CurrentChatCubit>(context)
                            .deleteUserFromChatEvent(
                          createGroupchatLeftUserDto:
                              CreateGroupchatLeftUserDto(
                            userId: userId,
                            leftGroupchatTo: chatState.currentChat.id,
                          ),
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
  }
}
