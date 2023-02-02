import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:skeletons/skeletons.dart';
import 'package:social_media_app_flutter/application/bloc/chat/chat_cubit.dart';
import 'package:social_media_app_flutter/presentation/router/router.gr.dart';
import 'package:social_media_app_flutter/presentation/widgets/chat_list.dart';

class HomeChatPage extends StatelessWidget {
  const HomeChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ChatCubit>(context).getChatsViaApi();

    return PlatformScaffold(
      appBar: PlatformAppBar(
        title: const Text('Social Media App'),
      ),
      body: BlocBuilder<ChatCubit, ChatState>(
        builder: (context, state) {
          if (state is ChatLoaded) {
            return ChatList(chats: state.chats);
          } else if (state is ChatLoading) {
            return SkeletonListView(
              itemBuilder: (p0, p1) {
                return SkeletonListTile(
                  hasSubtitle: true,
                  titleStyle: const SkeletonLineStyle(width: 100, height: 22),
                  subtitleStyle: const SkeletonLineStyle(
                      width: double.infinity, height: 16),
                  leadingStyle: const SkeletonAvatarStyle(
                    shape: BoxShape.circle,
                  ),
                );
              },
            );
          } else {
            return Center(
              child: TextButton(
                child: Text(
                  state is ChatError ? state.message : "Daten Laden",
                ),
                onPressed: () =>
                    BlocProvider.of<ChatCubit>(context).getChatsViaApi(),
              ),
            );
          }
        },
      ),
      material: (context, platform) => MaterialScaffoldData(
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => AutoRouter.of(context).push(
            const NewGroupchatWrapperPageRoute(),
          ),
          icon: const Icon(Icons.chat_bubble),
          label: Text(
            'Neuer Chat',
            style: Theme.of(context).textTheme.labelLarge,
          ),
        ),
      ),
    );
  }
}
