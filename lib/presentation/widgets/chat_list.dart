import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app_flutter/domain/entities/groupchat/groupchat_entity.dart';
import 'package:social_media_app_flutter/presentation/router/router.gr.dart';

class ChatList extends StatelessWidget {
  final List<GroupchatEntity> chats;
  const ChatList({super.key, required this.chats});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemBuilder: (context, index) {
        return ListTile(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(5),
            ),
          ),
          title: Text(chats[index].title ?? "Kein Titel"),
          onTap: () {
            AutoRouter.of(context).push(
              ChatPageRoute(groupchat: chats[index]),
            );
          },
        );
      },
      itemCount: chats.length,
    );
  }
}
