import 'package:flutter/material.dart';
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
      body: const ChatList(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => {Navigator.pushNamed(context, '/newGroupchat')},
        icon: const Icon(Icons.chat_bubble),
        label: const Text('Neuer Chat'),
      ),
    );
  }
}
