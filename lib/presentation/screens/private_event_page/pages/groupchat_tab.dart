import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app_flutter/application/bloc/chat/chat_bloc.dart';
import 'package:social_media_app_flutter/domain/entities/groupchat/groupchat_entity.dart';
import 'package:social_media_app_flutter/presentation/widgets/chat_page/message_area.dart';
import 'package:social_media_app_flutter/presentation/widgets/chat_page/message_input.dart';

class GroupchatTab extends StatelessWidget {
  final String? connectedGroupchat;
  const GroupchatTab({super.key, this.connectedGroupchat});

  @override
  Widget build(BuildContext context) {
    if (connectedGroupchat == null) {
      return const Center(
        child: Text("Kein Gruppenchat für dieses Event gefunden"),
      );
    }

    return BlocBuilder<ChatBloc, ChatState>(
      builder: (context, state) {
        if (state is ChatStateLoaded) {
          GroupchatEntity foundGroupchat = GroupchatEntity(
            id: "",
            users: [],
            leftUsers: [],
          );

          for (final groupchat in state.chats) {
            if (groupchat.id == connectedGroupchat) {
              foundGroupchat = groupchat;
              break;
            }
          }

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              children: [
                MessageArea(groupchatTo: foundGroupchat.id),
                const SizedBox(height: 8),
                MessageInput(groupchatTo: foundGroupchat.id),
                const SizedBox(height: 8),
              ],
            ),
          );
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
      },
    );
  }
}
