import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';
import 'package:social_media_app_flutter/application/bloc/chat/current_chat_cubit.dart';
import 'package:social_media_app_flutter/domain/entities/groupchat/groupchat_user_entity.dart';
import 'package:social_media_app_flutter/presentation/router/router.gr.dart';
import 'package:social_media_app_flutter/presentation/widgets/chat_page/chat_info_page/user_list/user_list_groupchat.dart';

class UserListWidgetChatInfoPage extends StatelessWidget {
  final CurrentChatState chatState;
  final GroupchatUserEntity? currentGroupchatUser;
  const UserListWidgetChatInfoPage({
    super.key,
    required this.chatState,
    this.currentGroupchatUser,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (chatState.currentChat.users != null) ...[
          Text(
            "Midglieder: ${chatState.currentChat.users!.length}",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          if (chatState.currentChat.users!.isNotEmpty) ...{
            const SizedBox(height: 8)
          },
          if (currentGroupchatUser != null &&
              currentGroupchatUser!.admin != null &&
              currentGroupchatUser!.admin == true) ...{
            // add user
            ListTile(
              leading: const Icon(
                Icons.person_add,
                color: Colors.green,
              ),
              title: const Text(
                "User zum Chat hinzufügen",
                style: TextStyle(color: Colors.green),
              ),
              onTap: () {
                AutoRouter.of(context).push(
                  ChatAddUserPageRoute(),
                );
              },
            )
          },
          UserListGroupchat(
            groupchatUsers: chatState.currentChat.users!,
            groupchatId: chatState.currentChat.id,
            currentGrouppchatUser: currentGroupchatUser,
          ),
        ] else if (chatState.currentChat.users == null &&
            chatState is CurrentChatLoading) ...[
          SkeletonListTile(
            hasSubtitle: true,
            hasLeading: false,
            titleStyle: const SkeletonLineStyle(
              width: double.infinity,
              height: 22,
            ),
            subtitleStyle: const SkeletonLineStyle(
              width: double.infinity,
              height: 16,
            ),
          ),
        ] else ...[
          Text(
            "Konnte die Gruppenchat Benutzer nicht Laden",
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ],
      ],
    );
  }
}
