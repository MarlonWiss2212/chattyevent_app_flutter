import 'package:chattyevent_app_flutter/application/bloc/auth/auth_state.dart';
import 'package:chattyevent_app_flutter/application/bloc/profile_page/profile_page_cubit.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/chat_message/chat_message_list.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletons/skeletons.dart';

class ProfileChatPageMessageArea extends StatelessWidget {
  const ProfileChatPageMessageArea({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfilePageCubit, ProfilePageState>(
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
        final currentUser =
            BlocProvider.of<AuthCubit>(context).state.currentUser;
        return ChatMessageList(
          key: Key("${state.user.id} chatMessageList"),
          messages: state.messages,
          users: [state.user, currentUser],
          usersCount: 2,
          currentUserId: currentUser.id,
          loadMoreMessages: () {
            return BlocProvider.of<ProfilePageCubit>(context).loadMessages();
          },
          deleteMessage: (id) => BlocProvider.of<ProfilePageCubit>(context)
              .deleteMessageViaApi(id: id),
        );
      },
    );
  }
}
