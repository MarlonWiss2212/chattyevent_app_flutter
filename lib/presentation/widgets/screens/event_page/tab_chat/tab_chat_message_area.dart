import 'package:chattyevent_app_flutter/application/bloc/auth/auth_state.dart';
import 'package:chattyevent_app_flutter/application/bloc/current_event/current_event_cubit.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/chat_message/chat_message_list.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletons/skeletons.dart';

class TabChatMessageArea extends StatelessWidget {
  const TabChatMessageArea({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrentEventCubit, CurrentEventState>(
      builder: (context, state) {
        if (state.loadingMessages == false && state.messages.isEmpty) {
          return Center(
            child: const Text("general.messageArea.noMessagesText").tr(),
          );
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
          key: Key("${state.event.id} chatMessageList"),
          messages: state.messages,
          users: [...state.eventUsers, ...state.eventLeftUsers],
          usersCount: state.eventUsers.length,
          currentUserId:
              BlocProvider.of<AuthCubit>(context).state.currentUser.id,
          loadMoreMessages: () {
            return BlocProvider.of<CurrentEventCubit>(context).loadMessages();
          },
          deleteMessage: (id) => BlocProvider.of<CurrentEventCubit>(context)
              .deleteMessageViaApi(id: id),
        );
      },
    );
  }
}
