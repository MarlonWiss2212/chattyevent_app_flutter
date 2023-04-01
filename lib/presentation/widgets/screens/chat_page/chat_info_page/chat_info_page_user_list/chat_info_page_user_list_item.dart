import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app_flutter/application/bloc/chat/current_chat_cubit.dart';
import 'package:social_media_app_flutter/core/dto/groupchat/update_groupchat_user_dto.dart';
import 'package:social_media_app_flutter/domain/entities/groupchat/user_with_groupchat_user_data.dart';
import 'package:social_media_app_flutter/presentation/router/router.gr.dart';
import 'package:social_media_app_flutter/presentation/widgets/general/user_list/user_list_tile.dart';

class ChatInfoPageUserListItem extends StatelessWidget {
  final UserWithGroupchatUserData user;
  final UserWithGroupchatUserData currentUser;
  const ChatInfoPageUserListItem({
    super.key,
    required this.user,
    required this.currentUser,
  });

  @override
  Widget build(BuildContext context) {
    final bool userIsAdmin = user.admin != null && user.admin! == true;

    return UserListTile(
      user: user,
      subtitle: userIsAdmin
          ? Text(
              "Admin",
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
              ),
              overflow: TextOverflow.ellipsis,
            )
          : const Text(
              "Nicht Admin",
              overflow: TextOverflow.ellipsis,
            ),
      customTitle: user.usernameForChat != null ? user.usernameForChat! : null,
      items: [
        if (currentUser.admin != null &&
            currentUser.admin == true &&
            currentUser.id != user.id) ...{
          PopupMenuItem(
            child: const Text("Kicken"),
            onTap: () =>
                BlocProvider.of<CurrentChatCubit>(context).deleteUserFromChat(
              userId: user.id,
            ),
          ),
        },
        if (currentUser.admin == true) ...{
          PopupMenuItem(
            child: userIsAdmin
                ? const Text("Admin degradieren")
                : const Text("Zum Admin machen"),
            onTap: () => BlocProvider.of<CurrentChatCubit>(context)
                .updateGroupchatUserViaApi(
              userId: user.id,
              updateGroupchatUserDto:
                  UpdateGroupchatUserDto(admin: userIsAdmin ? false : true),
            ),
          )
        },
        if (currentUser.id == user.id) ...[
          PopupMenuItem(
            child: const Text("Chat username ändern"),
            onTap: () => AutoRouter.of(context).push(
              const ChatChangeChatUsernamePageRoute(),
            ),
          )
        ]
      ],
    );
  }
}
