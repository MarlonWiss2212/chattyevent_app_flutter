import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app_flutter/application/bloc/chat/chat_bloc.dart';
import 'package:social_media_app_flutter/domain/entities/groupchat/groupchat_entity.dart';
import 'package:social_media_app_flutter/domain/entities/private_event_entity.dart';
import 'package:social_media_app_flutter/presentation/screens/chat_page.dart';

class PrivateEventPage extends StatefulWidget {
  final PrivateEventEntity privateEvent;
  const PrivateEventPage({required this.privateEvent, super.key});

  @override
  State<PrivateEventPage> createState() => _PrivateEventPageState();
}

class _PrivateEventPageState extends State<PrivateEventPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.privateEvent.title ?? "Kein Titel"),
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.chat_bubble)),
              Tab(icon: Icon(Icons.event)),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            PrivateEventPageGroupchatPage(
              connectedGroupchatId: widget.privateEvent.connectedGroupchat,
            ),
            PrivateEventPageInfoPage(privateEvent: widget.privateEvent)
          ],
        ),
      ),
    );
  }
}

class PrivateEventPageGroupchatPage extends StatelessWidget {
  final String? connectedGroupchatId;
  const PrivateEventPageGroupchatPage(
      {required this.connectedGroupchatId, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatBloc, ChatState>(builder: (context, state) {
      if (state is ChatStateLoaded) {
        GroupchatEntity foundGroupchat = GroupchatEntity(
          id: "",
          users: [],
          leftUsers: [],
        );

        for (final groupchat in state.chats) {
          if (groupchat.id == connectedGroupchatId) {
            foundGroupchat = groupchat;
            break;
          }
        }

        return ChatPageContent(groupchat: foundGroupchat);
      } else if (state is ChatStateLoading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
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
    });
  }
}

class PrivateEventPageInfoPage extends StatelessWidget {
  final PrivateEventEntity privateEvent;
  const PrivateEventPageInfoPage({required this.privateEvent, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Center(
        child: Text(privateEvent.title ?? "Kein Titel"),
      ),
    );
  }
}
