import 'package:flutter/material.dart';
import 'package:social_media_app_flutter/domain/entities/groupchat/groupchat_entity.dart';

class SelectGroupchatListItemNewPrivateEvent extends StatelessWidget {
  final GroupchatEntity groupchat;
  final Function onTap;

  const SelectGroupchatListItemNewPrivateEvent({
    super.key,
    required this.groupchat,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: const BorderRadius.all(Radius.circular(8.0)),
      onTap: () {
        onTap();
      },
      child: SizedBox(
        height: 70,
        width: 70,
        child: Card(
          color: Theme.of(context).colorScheme.secondaryContainer,
          child: Center(child: Text(groupchat.title ?? "Kein Titel")),
        ),
      ),
    );
  }
}
