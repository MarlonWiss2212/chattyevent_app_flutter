import 'dart:math';
import 'package:flutter/material.dart';
import 'package:social_media_app_flutter/domain/entities/groupchat/groupchat_entity.dart';
import 'package:social_media_app_flutter/presentation/widgets/chat_list/chat_grid_list_item.dart';

class ChatGridList extends StatelessWidget {
  final List<GroupchatEntity> groupchats;
  final Function(GroupchatEntity groupchat)? onLongPress;
  final Function(GroupchatEntity groupchat)? onPress;
  final Widget Function(GroupchatEntity groupchat)? button;

  const ChatGridList({
    super.key,
    required this.groupchats,
    this.button,
    this.onLongPress,
    this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemBuilder: (context, index) {
        return ChatGridListItem(
          chat: groupchats[index],
          button: button != null ? button!(groupchats[index]) : null,
          onLongPress: onLongPress == null
              ? null
              : () => onLongPress!(groupchats[index]),
          onPress: onPress == null ? null : () => onPress!(groupchats[index]),
        );
      },
      itemCount: groupchats.length,
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: max(
          (MediaQuery.of(context).size.width ~/ 150).toInt(),
          1,
        ),
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
      ),
    );
  }
}
