import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app_flutter/application/bloc/chat/chat_bloc.dart';
import 'package:social_media_app_flutter/presentation/router/router.gr.dart';

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
            return ListView.builder(
              padding: const EdgeInsets.all(8),
              itemBuilder: (context, index) {
                return ListTile(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(5),
                    ),
                  ),
                  title: Text(state.chats[index].title ?? "Kein Titel"),
                  onTap: () {
                    AutoRouter.of(context).push(
                      ChatPageRoute(groupchat: state.chats[index]),
                    );
                    ;
                  },
                );
              },
              itemCount: state.chats.length,
            );
          } else if (state is ChatStateLoading) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return Center(
              child: TextButton(
                child: Text(
                  state is ChatStateError ? state.message : "Daten laden",
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
        onPressed: () =>
            AutoRouter.of(context).push(const NewGroupchatPageRoute()),
        icon: const Icon(Icons.chat_bubble),
        label: const Text('Neuer Chat'),
      ),
    );
  }
}
