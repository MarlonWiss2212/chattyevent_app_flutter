import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:social_media_app_flutter/application/bloc/chat/current_chat_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/message/message_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/user/user_cubit.dart';
import 'package:social_media_app_flutter/domain/filter/get_messages_filter.dart';
import 'package:social_media_app_flutter/presentation/router/router.gr.dart';
import 'package:social_media_app_flutter/presentation/widgets/chat_page/message_area.dart';
import 'package:social_media_app_flutter/presentation/widgets/chat_page/message_input.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({@PathParam('id') required this.groupchatId, super.key});
  final String groupchatId;

  @override
  Widget build(BuildContext context) {
    // load data here so that it does not get double loaded when the bloc state changes
    BlocProvider.of<UserCubit>(context).getUsersViaApi();

    BlocProvider.of<MessageCubit>(context).getMessages(
      getMessagesFilter: GetMessagesFilter(groupchatTo: groupchatId),
    );

    return BlocBuilder<CurrentChatCubit, CurrentChatState>(
      builder: (context, state) {
        return PlatformScaffold(
          appBar: PlatformAppBar(
            leading: const AutoLeadingButton(),
            title: Row(
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
          body: state.loadingChat && state.currentChat.id == ""
              ? Center(child: PlatformCircularProgressIndicator())
              : state.currentChat.id != ""
                  ? Column(
                      children: [
                        if (state.loadingChat) ...{
                          const LinearProgressIndicator()
                        },
                        Expanded(
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Column(
                              children: [
                                MessageArea(groupchatTo: groupchatId),
                                const SizedBox(height: 8),
                                MessageInput(groupchatTo: groupchatId),
                                const SizedBox(height: 8)
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                  : Center(
                      child: Text(
                        "Fehler beim Laden des Chats mit der Id $groupchatId",
                        textAlign: TextAlign.center,
                      ),
                    ),
        );
      },
    );
  }
}
