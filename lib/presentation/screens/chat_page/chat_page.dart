import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:social_media_app_flutter/application/bloc/chat/chat_bloc.dart';
import 'package:social_media_app_flutter/application/bloc/message/message_bloc.dart';
import 'package:social_media_app_flutter/application/bloc/user/user_bloc.dart';
import 'package:social_media_app_flutter/domain/entities/groupchat/groupchat_entity.dart';
import 'package:social_media_app_flutter/domain/filter/get_messages_filter.dart';
import 'package:social_media_app_flutter/presentation/router/router.gr.dart';
import 'package:social_media_app_flutter/presentation/widgets/chat_page/message_area.dart';
import 'package:social_media_app_flutter/presentation/widgets/chat_page/message_input.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({@PathParam('id') required this.groupchatId, super.key});
  final String groupchatId;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    // load data here so that it does not get double loaded when the bloc state changes
    BlocProvider.of<UserBloc>(context).add(GetUsersEvent());

    BlocProvider.of<MessageBloc>(context).add(
      GetMessagesEvent(
        getMessagesFilter: GetMessagesFilter(groupchatTo: widget.groupchatId),
      ),
    );

    return BlocBuilder<ChatBloc, ChatState>(
      builder: (context, state) {
        GroupchatEntity? foundGroupchat;

        if (state is ChatStateLoaded) {
          for (final chat in state.chats) {
            if (chat.id == widget.groupchatId) {
              foundGroupchat = chat;
              break;
            }
          }
        }

        if (foundGroupchat == null) {
          return PlatformScaffold(
            appBar: PlatformAppBar(
              leading: const AutoLeadingButton(),
              title: Hero(
                tag: "${widget.groupchatId} title",
                child: const Text("Kein Titel"),
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
            body: const Center(child: Text("Chat nicht gefunden")),
          );
        }

        return PlatformScaffold(
          appBar: PlatformAppBar(
            leading: const AutoLeadingButton(),
            title: Hero(
              tag: "${widget.groupchatId} title",
              child: Text(foundGroupchat.title ?? "Kein Titel"),
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
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              children: [
                MessageArea(groupchatTo: widget.groupchatId),
                const SizedBox(height: 8),
                MessageInput(groupchatTo: widget.groupchatId),
                const SizedBox(height: 8)
              ],
            ),
          ),
        );
      },
    );
  }
}
