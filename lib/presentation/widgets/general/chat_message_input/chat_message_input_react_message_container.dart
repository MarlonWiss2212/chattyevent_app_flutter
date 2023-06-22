import 'package:chattyevent_app_flutter/application/bloc/add_message/add_message_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/auth/auth_cubit.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/chat_message/chat_message_react_message_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatMessageInputReactMessageContainer extends StatelessWidget {
  const ChatMessageInputReactMessageContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddMessageCubit, AddMessageState>(
      builder: (context, state) {
        if (state.messageToReactToWithUser == null) {
          return const SizedBox();
        }
        return AnimatedContainer(
          //TODO animate position
          duration: const Duration(seconds: 1),
          curve: Curves.elasticIn,
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
            ),
            child: ChatMessageReactMessageContainer(
              messageAndUser: MessageAndUser(
                message: state.messageToReactToWithUser!.message,
                user: state.messageToReactToWithUser!.user,
              ),
              isInput: true,
              currentUserId:
                  BlocProvider.of<AuthCubit>(context).state.currentUser.id,
            ),
          ),
        );
      },
    );
  }
}
