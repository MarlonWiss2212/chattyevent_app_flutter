import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';
import 'package:social_media_app_flutter/application/bloc/chat/current_chat_cubit.dart';
import 'package:social_media_app_flutter/domain/entities/groupchat/groupchat_user_entity.dart';
import 'package:social_media_app_flutter/domain/entities/groupchat/user_with_groupchat_user_data.dart';
import 'package:social_media_app_flutter/presentation/widgets/chat_page/chat_info_page/left_user_list/user_left_list_groupchat.dart';

class UserLeftListWidgetChatInfoPage extends StatelessWidget {
  final CurrentChatState chatState;
  final UserWithGroupchatUserData currentUserWithGroupchatUserData;
  const UserLeftListWidgetChatInfoPage({
    super.key,
    required this.chatState,
    required this.currentUserWithGroupchatUserData,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (chatState.currentChat.leftUsers != null) ...[
          Text(
            "Frühere Midglieder: ${chatState.usersWithLeftGroupchatUserData.length}",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          UserLeftListGroupchat(
            chatState: chatState,
            currentUserWithGroupchatUserData: currentUserWithGroupchatUserData,
          ),
        ] else if (chatState.usersWithLeftGroupchatUserData.isEmpty &&
            chatState.loadingChat) ...[
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
            "Konnte die Früheren Mitglieder nicht Laden",
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ],
      ],
    );
  }
}
