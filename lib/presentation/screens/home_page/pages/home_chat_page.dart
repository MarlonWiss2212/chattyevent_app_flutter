import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:social_media_app_flutter/application/bloc/chat/chat_cubit.dart';
import 'package:social_media_app_flutter/presentation/router/router.gr.dart';
import 'package:social_media_app_flutter/presentation/widgets/general/chat_list/chat_list.dart';
import 'package:social_media_app_flutter/presentation/widgets/dialog/buttons/ok_button.dart';
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
          BlocConsumer<ChatCubit, ChatState>(
            listener: (context, state) async {
              if (state.status == ChatStateStatus.error &&
                  state.error != null) {
                return await showPlatformDialog(
                  context: context,
                  builder: (context) {
                    return PlatformAlertDialog(
                      title: Text(state.error!.title),
                      content: Text(state.error!.message),
                      actions: const [OKButton()],
                    );
                  },
                );
              }
            },
            builder: (context, state) {
              if (state.chats.isEmpty &&
                  state.status != ChatStateStatus.loading) {
                return const SliverFillRemaining(
                  child: Center(
                    child: Text("Keine Chats"),
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
