import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app_flutter/application/bloc/chat/current_chat_cubit.dart';
import 'package:social_media_app_flutter/domain/entities/groupchat/user_with_groupchat_user_data.dart';
import 'package:social_media_app_flutter/domain/entities/user/user_entity.dart';
import 'package:social_media_app_flutter/presentation/widgets/user_list/user_list_tile.dart';

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
    return UserListTile(
      user: user,
      subtitle: user.admin != null && user.admin! == true
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
      items: currentUser.admin != null &&
              currentUser.admin == true &&
              currentUser.id != user.id
          ? [
              PopupMenuItem<void Function(UserEntity)>(
                child: const Text("Kicken"),
                onTap: () => BlocProvider.of<CurrentChatCubit>(context)
                    .deleteUserFromChat(
                  userId: user.id,
                ),
              ),
            ]
          : null,
    );
  }
}
