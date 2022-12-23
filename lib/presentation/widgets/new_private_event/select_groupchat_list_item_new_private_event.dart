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
        height: 100,
        width: 100,
        child: Card(
          color: Theme.of(context).colorScheme.secondaryContainer,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(groupchat.title ?? "Kein Titel"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
