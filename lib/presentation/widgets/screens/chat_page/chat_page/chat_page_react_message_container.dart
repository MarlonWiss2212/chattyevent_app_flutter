import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chattyevent_app_flutter/application/bloc/auth/auth_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/current_groupchat/current_chat_cubit.dart';
import 'package:chattyevent_app_flutter/domain/entities/message/message_entity.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/screens/chat_page/chat_page/chat_page_message_container.dart';

class ChatPageReactMessageContainer extends StatelessWidget {
  final String messageToReactTo;
  final bool isInputMessage;

  const ChatPageReactMessageContainer({
    super.key,
    required this.messageToReactTo,
    this.isInputMessage = false,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrentChatCubit, CurrentChatState>(
      builder: (context, state) {
        return Padding(
          padding: isInputMessage
              ? const EdgeInsets.all(0)
              : const EdgeInsets.all(8),
          child: ChatPageMessageContainer(
            isInputMessage: isInputMessage,
            message: state.messages.firstWhere(
              (element) => element.id == messageToReactTo,
              orElse: () => MessageEntity(
                id: messageToReactTo,
                createdAt: DateTime.now(),
              ),
            ),
            currentUserId:
                BlocProvider.of<AuthCubit>(context).state.currentUser.id,
            users: state.users,
            leftUsers: state.leftUsers,
            messageIsReactMessage: true,
          ),
        );
      },
    );
  }
}
