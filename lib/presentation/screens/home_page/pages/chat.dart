import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app_flutter/application/bloc/chat/chat_bloc.dart';
import 'package:social_media_app_flutter/presentation/router/router.gr.dart';
import 'package:social_media_app_flutter/presentation/widgets/chat_list.dart';

class Chat extends StatefulWidget {
  const Chat({super.key});

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ChatBloc, ChatState>(
        bloc: BlocProvider.of<ChatBloc>(context)
          ..add(
            ChatRequestEvent(),
          ),
        builder: (context, state) {
          if (state is ChatStateLoaded) {
            return ChatList(chats: state.chats);
          } else if (state is ChatStateLoading) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return Center(
              child: TextButton(
                child: Text(
                  state is ChatStateError ? state.message : "Daten Laden",
                ),
                onPressed: () => BlocProvider.of<ChatBloc>(context).add(
                  ChatRequestEvent(),
                ),
              ),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => AutoRouter.of(context).push(
          const NewGroupchatPageRoute(),
        ),
        icon: const Icon(Icons.chat_bubble),
        label: const Text('Neuer Chat'),
      ),
    );
  }
}
