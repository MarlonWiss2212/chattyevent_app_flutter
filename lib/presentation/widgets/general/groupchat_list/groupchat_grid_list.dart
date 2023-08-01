import 'dart:math';
import 'package:flutter/material.dart';
import 'package:chattyevent_app_flutter/domain/entities/groupchat/groupchat_entity.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/groupchat_list/groupchat_grid_list_item.dart';

class GroupchatGridList extends StatelessWidget {
  final List<GroupchatEntity> groupchats;
  final List<String>? highlightIds;
  final Function(GroupchatEntity groupchat)? onLongPress;
  final Function(GroupchatEntity groupchat)? onPress;
  final Widget Function(GroupchatEntity groupchat)? button;

  const GroupchatGridList({
    super.key,
    required this.groupchats,
    this.button,
    this.onLongPress,
    this.onPress,
    this.highlightIds,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemBuilder: (context, index) {
        bool highlighted = false;
        if (highlightIds != null) {
          final foundIndex = highlightIds!.indexWhere(
            (element) => element == groupchats[index].id,
          );
          if (foundIndex != -1) {
            highlighted = true;
          }
        }
        return GroupchatGridListItem(
          key: ObjectKey(groupchats[index]),
          highlighted: highlighted,
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
