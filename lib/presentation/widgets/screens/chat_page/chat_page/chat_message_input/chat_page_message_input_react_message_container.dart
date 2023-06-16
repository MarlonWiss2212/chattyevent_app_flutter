import 'package:chattyevent_app_flutter/application/bloc/add_message/add_message_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/auth/auth_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/current_groupchat/current_chat_cubit.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/screens/chat_page/chat_page/chat_page_react_message_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatPageMessageInputReactMessageContainer extends StatefulWidget {
  const ChatPageMessageInputReactMessageContainer({super.key});

  @override
  State<ChatPageMessageInputReactMessageContainer> createState() =>
      _ChatPageMessageInputReactMessageContainerState();
}

class _ChatPageMessageInputReactMessageContainerState
    extends State<ChatPageMessageInputReactMessageContainer> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddMessageCubit, AddMessageState>(
      builder: (context, state) {
        if (state.messageToReactTo == null) {
          return const SizedBox();
        }
        return AnimatedPositioned(
          //TODO animate position
          duration: const Duration(seconds: 1),
          curve: Curves.elasticIn,
          child: Scrollable(
            viewportBuilder: (context, position) =>
                BlocBuilder<CurrentChatCubit, CurrentChatState>(
              builder: (context, chatState) {
                return Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8),
                      ),
                    ),
                    child: ChatPageReactMessageContainer(
                      message: state.messageToReactTo!,
                      isInput: true,
                      users: chatState.users,
                      leftUsers: chatState.leftUsers,
                      currentUserId: BlocProvider.of<AuthCubit>(context)
                          .state
                          .currentUser
                          .id,
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
