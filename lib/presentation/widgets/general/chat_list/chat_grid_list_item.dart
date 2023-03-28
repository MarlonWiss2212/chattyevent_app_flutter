import 'package:flutter/material.dart';
import 'package:social_media_app_flutter/domain/entities/groupchat/groupchat_entity.dart';

class ChatGridListItem extends StatelessWidget {
  final GroupchatEntity chat;
  final bool highlighted;
  final Function? onLongPress;
  final Function? onPress;
  final Widget? button;

  const ChatGridListItem({
    super.key,
    required this.chat,
    this.highlighted = false,
    this.button,
    this.onLongPress,
    this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: const BorderRadius.all(Radius.circular(8.0)),
      onLongPress: onLongPress == null ? null : () => onLongPress!(),
      onTap: onPress == null ? null : () => onPress!(),
      child: Ink(
        child: Stack(
          children: [
            chat.profileImageLink != null
                ? Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      border: highlighted
                          ? Border.all(
                              color: Theme.of(context)
                                  .colorScheme
                                  .primaryContainer,
                              width: 4,
                            )
                          : null,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Hero(
                        tag: "${chat.id} profileImage",
                        child: Image.network(
                          chat.profileImageLink!,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  )
                : Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: highlighted
                          ? Border.all(
                              color: Theme.of(context)
                                  .colorScheme
                                  .primaryContainer,
                              width: 4,
                            )
                          : null,
                      color: Theme.of(context).colorScheme.secondaryContainer,
                    ),
                  ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Hero(
                    tag: "${chat.id} title",
                    child: Text(
                      chat.title ?? "Kein Name",
                      style: Theme.of(context).textTheme.labelMedium,
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
                    ),
                  ),
                  if (button != null) ...[
                    const SizedBox(height: 8),
                    Center(
                      child: button!,
                    ),
                  ]
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
