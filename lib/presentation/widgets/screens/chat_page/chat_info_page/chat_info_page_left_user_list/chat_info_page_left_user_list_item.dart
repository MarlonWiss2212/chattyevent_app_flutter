import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:chattyevent_app_flutter/application/bloc/current_groupchat/current_chat_cubit.dart';
import 'package:chattyevent_app_flutter/domain/entities/groupchat/groupchat_left_user_entity.dart';
import 'package:chattyevent_app_flutter/domain/entities/groupchat/groupchat_user_entity.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/user_list/user_list_tile.dart';

class ChatInfoPageLeftUserListItem extends StatelessWidget {
  final GroupchatLeftUserEntity leftUser;
  final GroupchatUserEntity currentUser;
  final CurrentGroupchatState state;

  const ChatInfoPageLeftUserListItem({
    super.key,
    required this.leftUser,
    required this.currentUser,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return UserListTile(
      user: leftUser,
      subtitle: leftUser.leftGroupchatAt != null
          ? Text(
              DateFormat.yMd().add_jm().format(leftUser.leftGroupchatAt!),
              overflow: TextOverflow.ellipsis,
            )
          : const Text(
              "Kein Datum",
              overflow: TextOverflow.ellipsis,
            ),
      items: state.currentUserAllowedWithPermission(
        permissionCheckValue: state.currentChat.permissions?.addUsers,
      )
          ? [
              PopupMenuItem(
                child: const Text("Hinzufügen"),
                onTap: () => BlocProvider.of<CurrentGroupchatCubit>(context)
                    .addUserToChat(
                  userId: leftUser.id,
                ),
              ),
            ]
          : null,
    );
  }
}
