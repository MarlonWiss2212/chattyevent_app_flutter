import 'package:auto_route/auto_route.dart';
import 'package:chattyevent_app_flutter/core/enums/groupchat/groupchat_user/groupchat_user_role_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chattyevent_app_flutter/application/bloc/current_groupchat/current_chat_cubit.dart';
import 'package:chattyevent_app_flutter/infastructure/dto/groupchat/groupchat_user/update_groupchat_user_dto.dart';
import 'package:chattyevent_app_flutter/domain/entities/groupchat/groupchat_user_entity.dart';
import 'package:chattyevent_app_flutter/presentation/router/router.gr.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/user_list/user_list_tile.dart';

class ChatInfoPageUserListItem extends StatelessWidget {
  final GroupchatUserEntity user;
  final GroupchatUserEntity currentUser;
  const ChatInfoPageUserListItem({
    super.key,
    required this.user,
    required this.currentUser,
  });

  @override
  Widget build(BuildContext context) {
    return UserListTile(
      user: user,
      subtitle: user.role != null && user.role == GroupchatUserRoleEnum.admin
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
        if (currentUser.role != null &&
            currentUser.role == GroupchatUserRoleEnum.admin &&
            currentUser.id != user.id) ...{
          PopupMenuItem(
            child: const Text("Kicken"),
            onTap: () => BlocProvider.of<CurrentGroupchatCubit>(context)
                .deleteUserFromChat(
              userId: user.id,
            ),
          ),
        },
        if (currentUser.role == GroupchatUserRoleEnum.admin) ...{
          PopupMenuItem(
            child: user.role == GroupchatUserRoleEnum.admin
                ? const Text("Admin degradieren")
                : const Text("Zum Admin machen"),
            onTap: () => BlocProvider.of<CurrentGroupchatCubit>(context)
                .updateGroupchatUserViaApi(
              userId: user.id,
              updateGroupchatUserDto: UpdateGroupchatUserDto(
                  role: user.role == GroupchatUserRoleEnum.admin
                      ? GroupchatUserRoleEnum.member
                      : GroupchatUserRoleEnum.admin),
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
