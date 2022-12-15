import 'package:flutter/material.dart';
import 'package:social_media_app_flutter/domain/entities/groupchat/groupchat_entity.dart';
import 'package:social_media_app_flutter/presentation/widgets/chat_page/message_area.dart';
import 'package:social_media_app_flutter/presentation/widgets/chat_page/message_input.dart';

class ChatPage extends StatelessWidget {
  final GroupchatEntity groupchat;
  const ChatPage({required this.groupchat, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(groupchat.title ?? "Kein Titel"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          children: [
            MessageArea(groupchatTo: groupchat.id),
            const SizedBox(height: 8),
            MessageInput(groupchatTo: groupchat.id),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
