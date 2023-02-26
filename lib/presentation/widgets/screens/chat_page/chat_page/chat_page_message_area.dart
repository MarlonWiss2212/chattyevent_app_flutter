import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletons/skeletons.dart';
import 'package:social_media_app_flutter/application/bloc/chat/current_chat_cubit.dart';
import 'package:social_media_app_flutter/presentation/widgets/screens/chat_page/chat_page/chat_page_message_list.dart';

class ChatPageMessageArea extends StatelessWidget {
  const ChatPageMessageArea({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrentChatCubit, CurrentChatState>(
      buildWhen: (previous, current) {
        if (previous.currentChat.messages?.length !=
            current.currentChat.messages?.length) {
          return true;
        }
        if (previous.loadingMessages != current.loadingMessages) {
          return true;
        }
        if (previous.usersWithGroupchatUserData.length !=
            current.usersWithGroupchatUserData.length) {
          return true;
        }
        if (previous.usersWithLeftGroupchatUserData.length !=
            current.usersWithLeftGroupchatUserData.length) {
          return true;
        }
        return true;
      },
      builder: (context, state) {
        final messagesAreNotLoaded = state.currentChat.messages == null &&
                state.loadingMessages == false ||
            state.currentChat.messages != null &&
                state.currentChat.messages!.isEmpty &&
                state.loadingMessages == false;

        const emptyReturn = Center(child: Text("Keine Nachrichten"));

        if (messagesAreNotLoaded) {
          return emptyReturn;
        }

        final loadingMessages =
            state.currentChat.messages == null && state.loadingMessages ||
                state.currentChat.messages!.isEmpty && state.loadingMessages;

        if (loadingMessages) {
          return SkeletonListView(
            itemBuilder: (p0, p1) {
              return SkeletonListTile(
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
              );
            },
          );
        }

        return ChatPageMessageList(
          groupchatTo: state.currentChat.id,
          usersWithGroupchatUserData: state.usersWithGroupchatUserData,
          usersWithLeftGroupchatUserData: state.usersWithLeftGroupchatUserData,
          messages: state.currentChat.messages!,
        );
      },
    );
  }
}
