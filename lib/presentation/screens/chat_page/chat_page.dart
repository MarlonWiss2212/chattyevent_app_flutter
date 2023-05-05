import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:chattyevent_app_flutter/application/bloc/auth/auth_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/current_groupchat/add_groupchat_message_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/current_groupchat/current_chat_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:chattyevent_app_flutter/core/injection.dart';
import 'package:chattyevent_app_flutter/presentation/router/router.gr.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/screens/chat_page/chat_page/chat_page_message_area.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/screens/chat_page/chat_page/chat_page_message_input.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({@PathParam('id') required this.groupchatId, super.key});
  final String groupchatId;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  void initState() {
    BlocProvider.of<CurrentChatCubit>(context).loadMessages();
    BlocProvider.of<CurrentChatCubit>(context).listenToMessages();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                  tag: "${widget.groupchatId} title",
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
        actions: [
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
              if (state.loadingChat || state.loadingMessages) {
                return const LinearProgressIndicator();
              }
              return const SizedBox();
            },
          ),
          Expanded(
            child: BlocProvider.value(
              value: AddGroupchatMessageCubit(
                AddGroupchatMessageState(groupchatTo: widget.groupchatId),
                notificationCubit: BlocProvider.of<NotificationCubit>(context),
                currentChatCubit: BlocProvider.of<CurrentChatCubit>(context),
                groupchatMessageUseCases: serviceLocator(
                  param1: BlocProvider.of<AuthCubit>(context).state,
                ),
              ),
              child: Column(
                children: [
                  const Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: ChatPageMessageArea(),
                    ),
                  ),
                  const Divider(height: 2),
                  ChatPageMessageInput(groupchatTo: widget.groupchatId),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
