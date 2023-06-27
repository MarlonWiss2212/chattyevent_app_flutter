import 'package:chattyevent_app_flutter/application/bloc/auth/auth_cubit.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/chat_message/chat_message_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletons/skeletons.dart';
import 'package:chattyevent_app_flutter/application/bloc/current_groupchat/current_chat_cubit.dart';

class ChatPageMessageArea extends StatelessWidget {
  const ChatPageMessageArea({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrentGroupchatCubit, CurrentGroupchatState>(
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
        return false;
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

        return ChatMessageList(
          messages: state.messages,
          users: [...state.users, ...state.leftUsers],
          currentUserId:
              BlocProvider.of<AuthCubit>(context).state.currentUser.id,
          loadMoreMessages: () {
            if (state.loadingMessages == false) {
              BlocProvider.of<CurrentGroupchatCubit>(context).loadMessages();
            }
          },
        );
      },
    );
  }
}
