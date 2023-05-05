import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chattyevent_app_flutter/application/bloc/chat/chat_cubit.dart';
import 'package:chattyevent_app_flutter/presentation/router/router.gr.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/chat_list/chat_list.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/screens/home_page/pages/home_chat_page/home_chat_page_skeleton.dart';

class HomeChatPage extends StatefulWidget {
  const HomeChatPage({super.key});

  @override
  State<HomeChatPage> createState() => _HomeChatPageState();
}

class _HomeChatPageState extends State<HomeChatPage> {
  @override
  void initState() {
    BlocProvider.of<ChatCubit>(context).getChatsViaApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            snap: true,
            floating: true,
            expandedHeight: 100,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                "Chats",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
              ),
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
