import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:social_media_app_flutter/application/bloc/auth/auth_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/chat/current_chat_cubit.dart';
import 'package:social_media_app_flutter/domain/entities/groupchat/groupchat_user_entity.dart';
import 'package:social_media_app_flutter/presentation/widgets/chat_page/chat_info_page/description_widget_chat_info_page.dart';
import 'package:social_media_app_flutter/presentation/widgets/chat_page/chat_info_page/leave_chat_widget_chat_info_page.dart';
import 'package:social_media_app_flutter/presentation/widgets/chat_page/chat_info_page/left_user_list/user_left_list_widget_chat_info_page.dart';
import 'package:social_media_app_flutter/presentation/widgets/chat_page/chat_info_page/private_event_list_groupchat.dart';
import 'package:social_media_app_flutter/presentation/widgets/chat_page/chat_info_page/user_list/user_list_widget_chat_info_page.dart';
import 'package:social_media_app_flutter/presentation/widgets/circle_image/cirlce_image.dart';
import 'package:social_media_app_flutter/presentation/widgets/divider.dart';

class ChatInfoPageDetails extends StatelessWidget {
  final CurrentChatState chatState;
  const ChatInfoPageDetails({
    super.key,
    required this.chatState,
  });

  @override
  Widget build(BuildContext context) {
    final currentUserId = Jwt.parseJwt(
        (BlocProvider.of<AuthCubit>(context).state as AuthLoaded).token)["sub"];
    GroupchatUserEntity? currentGroupchatUser =
        chatState.currentChat.users?.firstWhere(
      (element) => element.userId == currentUserId,
      orElse: () => GroupchatUserEntity(userId: ""),
    );

    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 20),
          CircleImage(
            imageLink: chatState.currentChat.profileImageLink,
          ),
          const SizedBox(height: 20),
          DescriptionChatInfoPage(chatState: chatState),
          const CustomDivider(),
          PrivateEventListGroupchat(chatState: chatState),
          const CustomDivider(),
          UserListWidgetChatInfoPage(
            chatState: chatState,
            currentGroupchatUser: currentGroupchatUser,
          ),
          const CustomDivider(),
          UserLeftListWidgetChatInfoPage(
            chatState: chatState,
            currentGroupchatUser: currentGroupchatUser,
          ),
          const CustomDivider(),
          LeaveChatWidgetChatInfoPage(
            chatState: chatState,
            currentUserId: currentUserId,
          ),
        ],
      ),
    );
  }
}
