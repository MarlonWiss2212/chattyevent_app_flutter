import 'package:chattyevent_app_flutter/domain/entities/request/request_entity.dart';
import 'package:chattyevent_app_flutter/domain/entities/user/user_entity.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chattyevent_app_flutter/application/bloc/current_groupchat/current_chat_cubit.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/user_list/user_list_tile.dart';

class ChatInfoPageInvitationListItem extends StatelessWidget {
  final RequestEntity invitation;

  const ChatInfoPageInvitationListItem({super.key, required this.invitation});

  @override
  Widget build(BuildContext context) {
    final UserEntity? user = invitation.invitationData?.invitedUser;
    if (user == null) {
      return const Text(
              "groupchatPage.infoPage.invitationList.errorToDisplayOneInvitationText")
          .tr();
    }
    return BlocBuilder<CurrentGroupchatCubit, CurrentGroupchatState>(
      builder: (context, state) {
        return UserListTile(
          user: user,
          subtitle: const Text(
            "groupchatPage.infoPage.invitationList.invitedByText",
          ).tr(
            args: [invitation.createdBy.username ?? ""],
          ),
          items: state.currentUserAllowedWithPermission(
            permissionCheckValue: state.currentChat.permissions?.addUsers,
          )
              ? [
                  PopupMenuItem(
                    child: const Text(
                      "groupchatPage.infoPage.invitationList.deleteInvitationText",
                    ).tr(),
                    onTap: () => BlocProvider.of<CurrentGroupchatCubit>(context)
                        .deleteRequestViaApiAndReloadRequests(
                      request: invitation,
                    ),
                  ),
                ]
              : null,
        );
      },
    );
  }
}
