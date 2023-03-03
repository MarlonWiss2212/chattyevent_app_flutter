import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:social_media_app_flutter/application/bloc/chat/current_chat_cubit.dart';
import 'package:social_media_app_flutter/domain/entities/groupchat/user_with_groupchat_user_data.dart';
import 'package:social_media_app_flutter/domain/entities/groupchat/user_with_left_groupchat_user_data.dart';
import 'package:social_media_app_flutter/presentation/widgets/user_list/user_list_tile.dart';

class ChatInfoPageLeftUserListItem extends StatelessWidget {
  final UserWithLeftGroupchatUserData user;
  final UserWithGroupchatUserData currentUser;

  const ChatInfoPageLeftUserListItem({
    super.key,
    required this.user,
    required this.currentUser,
  });

  @override
  Widget build(BuildContext context) {
    return UserListTile(
      authId: user.authId,
      profileImageLink: user.profileImageLink,
      subtitle: user.leftAt != null
          ? Text(
              DateFormat.yMd().add_jm().format(user.leftAt!),
              overflow: TextOverflow.ellipsis,
            )
          : const Text(
              "Kein Datum",
              overflow: TextOverflow.ellipsis,
            ),
      username: user.username ?? "Kein Username",
      userId: user.id,
      longPress: currentUser.admin != null &&
              currentUser.admin == true &&
              currentUser.id != user.id
          ? (userId) {
              showMenu(
                position: const RelativeRect.fromLTRB(0, double.infinity, 0, 0),
                context: context,
                items: [
                  PopupMenuItem(
                    child: const Text("Hinzufügen"),
                    onTap: () => BlocProvider.of<CurrentChatCubit>(context)
                        .addUserToChat(userId: userId),
                  ),
                ],
              );
            }
          : null,
    );
  }
}
