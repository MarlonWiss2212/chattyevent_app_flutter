import 'package:chattyevent_app_flutter/application/bloc/auth/auth_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/current_private_event/current_private_event_cubit.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/chat_message/chat_message_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletons/skeletons.dart';

class TabChatMessageArea extends StatelessWidget {
  const TabChatMessageArea({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrentPrivateEventCubit, CurrentPrivateEventState>(
      buildWhen: (previous, current) {
        if (previous.messages.length != current.messages.length) {
          return true;
        }
        if (previous.loadingMessages != current.loadingMessages) {
          return true;
        }
        if (previous.privateEventUsers.length !=
            current.privateEventUsers.length) {
          return true;
        }
        if (previous.privateEventLeftUsers.length !=
            current.privateEventLeftUsers.length) {
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
          users: [...state.privateEventUsers, ...state.privateEventLeftUsers],
          currentUserId:
              BlocProvider.of<AuthCubit>(context).state.currentUser.id,
          loadMoreMessages: () {
            if (state.loadingMessages == false) {
              BlocProvider.of<CurrentPrivateEventCubit>(context).loadMessages();
            }
          },
        );
      },
    );
  }
}
