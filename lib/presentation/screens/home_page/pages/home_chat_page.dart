import 'package:auto_route/auto_route.dart';
import 'package:chattyevent_app_flutter/application/bloc/requests/requests_cubit.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/request/request_horizontal_list.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chattyevent_app_flutter/application/bloc/chat/chat_cubit.dart';
import 'package:chattyevent_app_flutter/presentation/router/router.gr.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/screens/home_page/pages/home_chat_page/chat_list.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/screens/home_page/pages/home_chat_page/home_chat_page_skeleton.dart';

@RoutePage()
class HomeChatPage extends StatefulWidget {
  const HomeChatPage({super.key});

  @override
  State<HomeChatPage> createState() => _HomeChatPageState();
}

class _HomeChatPageState extends State<HomeChatPage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ChatCubit>(context).getChatsViaApi();
    BlocProvider.of<RequestsCubit>(context).getRequestsViaApi(reload: true);
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
            centerTitle: true,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              titlePadding: const EdgeInsets.only(bottom: 16),
              title: Text(
                "homePage.pages.chatPage.title",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
              ).tr(),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () => AutoRouter.of(context).push(
                  const NewGroupchatWrapperRoute(),
                ),
              ),
            ],
          ),
          CupertinoSliverRefreshControl(
            onRefresh: () {
              return Future.wait([
                BlocProvider.of<RequestsCubit>(context)
                    .getRequestsViaApi(reload: true),
                BlocProvider.of<ChatCubit>(context).getChatsViaApi()
              ]);
            },
          ),
          const SliverPadding(
            padding: EdgeInsets.all(8),
            sliver: SliverToBoxAdapter(
              child: RequestHorizontalList(),
            ),
          ),
          BlocBuilder<ChatCubit, ChatState>(
            builder: (context, state) {
              if (state.chats.isEmpty &&
                  state.status != ChatStateStatus.loading) {
                return SliverFillRemaining(
                  child: Center(
                    child:
                        const Text("homePage.pages.chatPage.noChatsText").tr(),
                  ),
                );
              }
              if (state.chats.isEmpty &&
                  state.status == ChatStateStatus.loading) {
                return const SliverFillRemaining(child: HomeChatPageSkeleton());
              }
              return ChatList(chats: state.chats);
            },
          ),
        ],
      ),
    );
  }
}
