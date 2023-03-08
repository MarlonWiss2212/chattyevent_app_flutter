import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app_flutter/application/bloc/auth/auth_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/chat/current_chat_cubit.dart';
import 'package:social_media_app_flutter/domain/entities/message/message_entity.dart';
import 'package:social_media_app_flutter/presentation/widgets/screens/chat_page/chat_page/chat_page_message_container.dart';

class ChatPageReactMessageContainer extends StatelessWidget {
  final String messageToReactTo;
  final bool? showImage;

  const ChatPageReactMessageContainer({
    super.key,
    required this.messageToReactTo,
    this.showImage,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrentChatCubit, CurrentChatState>(
      builder: (context, state) {
        return ChatPageMessageContainer(
          showImage: showImage ?? true,
          message: state.currentChat.messages != null
              ? state.currentChat.messages!.firstWhere(
                  (element) => element.id == messageToReactTo,
                  orElse: () => MessageEntity(id: messageToReactTo),
                )
              : MessageEntity(id: messageToReactTo),
          currentUserId:
              BlocProvider.of<AuthCubit>(context).state.currentUser.id,
          usersWithGroupchatUserData: state.usersWithGroupchatUserData,
          usersWithLeftGroupchatUserData: state.usersWithLeftGroupchatUserData,
          showMessageReactTo: false,
        );
      },
    );
  }
}
