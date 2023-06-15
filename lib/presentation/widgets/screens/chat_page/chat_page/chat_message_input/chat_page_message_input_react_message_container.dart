import 'package:chattyevent_app_flutter/application/bloc/auth/auth_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/current_groupchat/add_groupchat_message_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/current_groupchat/current_chat_cubit.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/screens/chat_page/chat_page/chat_page_react_message_container.dart';
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
    return BlocBuilder<AddGroupchatMessageCubit, AddGroupchatMessageState>(
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
                );
              },
            ),
          ),
        );
      },
    );
  }
}
