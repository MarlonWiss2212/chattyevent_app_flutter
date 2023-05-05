import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletons/skeletons.dart';
import 'package:chattyevent_app_flutter/application/bloc/current_groupchat/current_chat_cubit.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/screens/chat_page/chat_page/chat_page_message_list.dart';

class ChatPageMessageArea extends StatelessWidget {
  const ChatPageMessageArea({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrentChatCubit, CurrentChatState>(
      buildWhen: (previous, current) {
        if (previous.messages.length != current.messages.length) {
          return true;
        }
        if (previous.loadingMessages != current.loadingMessages) {
          return true;
        }
        if (previous.users.length != current.users.length) {
          return true;
        }
        if (previous.leftUsers.length != current.leftUsers.length) {
          return true;
        }
        return true;
      },
      builder: (context, state) {
        if (state.loadingMessages == false && state.messages.isEmpty) {
          return const Center(child: Text("Keine Nachrichten"));
        }

        if (state.loadingMessages == true && state.messages.isEmpty) {
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
          users: state.users,
          leftUsers: state.leftUsers,
          messages: state.messages,
        );
      },
    );
  }
}
