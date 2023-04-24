import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app_flutter/application/bloc/chat/chat_cubit.dart';
import 'package:social_media_app_flutter/presentation/router/router.gr.dart';
import 'package:social_media_app_flutter/presentation/widgets/general/chat_list/chat_list.dart';
import 'package:social_media_app_flutter/presentation/widgets/screens/home_page/pages/home_chat_page/home_chat_page_skeleton.dart';

class HomeChatPage extends StatelessWidget {
  const HomeChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ChatCubit>(context).getChatsViaApi();

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            snap: true,
            floating: true,
            expandedHeight: 100,
            flexibleSpace: const FlexibleSpaceBar(
              title: Text("Chats"),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () => AutoRouter.of(context).push(
                  const NewGroupchatWrapperPageRoute(),
                ),
              ),
            ],
          ),
          CupertinoSliverRefreshControl(
            onRefresh: () =>
                BlocProvider.of<ChatCubit>(context).getChatsViaApi(),
          ),
          BlocBuilder<ChatCubit, ChatState>(
            builder: (context, state) {
              if (state.chatStates.isEmpty &&
                  state.status != ChatStateStatus.loading) {
                return const SliverFillRemaining(
                  child: Center(
                    child: Text("Keine Chats"),
                  ),
                );
              }
              if (state.chatStates.isEmpty &&
                  state.status == ChatStateStatus.loading) {
                return const SliverFillRemaining(child: HomeChatPageSkeleton());
              }
              return ChatList(chatStates: state.chatStates);
            },
          ),
        ],
      ),
    );
  }
}
