import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:social_media_app_flutter/application/bloc/chat/current_chat_cubit.dart';
import 'package:social_media_app_flutter/presentation/router/router.gr.dart';
import 'package:social_media_app_flutter/presentation/widgets/screens/chat_page/message_area.dart';
import 'package:social_media_app_flutter/presentation/widgets/screens/chat_page/message_input.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({@PathParam('id') required this.groupchatId, super.key});
  final String groupchatId;

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<CurrentChatCubit>(context).loadMessages();

    return PlatformScaffold(
      appBar: PlatformAppBar(
        leading: const AutoLeadingButton(),
        title: BlocBuilder<CurrentChatCubit, CurrentChatState>(
          builder: (context, state) {
            return Row(
              children: [
                CircleAvatar(
                  backgroundImage: state.currentChat.profileImageLink != null
                      ? NetworkImage(state.currentChat.profileImageLink!)
                      : null,
                  backgroundColor: state.currentChat.profileImageLink != null
                      ? null
                      : Theme.of(context).colorScheme.secondaryContainer,
                ),
                const SizedBox(width: 8),
                Hero(
                  tag: "$groupchatId title",
                  child: Text(
                    state.currentChat.title != null
                        ? state.currentChat.title!
                        : "Kein Titel",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
              ],
            );
          },
        ),
        trailingActions: [
          PlatformIconButton(
            icon: const Icon(Icons.info),
            onPressed: () => AutoRouter.of(context).push(
              ChatInfoPageRoute(),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          BlocBuilder<CurrentChatCubit, CurrentChatState>(
            builder: (context, state) {
              if (state.loadingChat) {
                return const LinearProgressIndicator();
              }
              return const SizedBox();
            },
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                children: [
                  const MessageArea(),
                  const SizedBox(height: 8),
                  MessageInput(groupchatTo: groupchatId),
                  const SizedBox(height: 8)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
