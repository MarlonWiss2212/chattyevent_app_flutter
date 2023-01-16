import 'package:flutter/material.dart';
import 'package:social_media_app_flutter/domain/entities/user_entity.dart';

class UserGridListItem extends StatelessWidget {
  final UserEntity user;
  final Function? onLongPress;
  final Function? onPress;
  final Widget? button;

  const UserGridListItem({
    super.key,
    required this.user,
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
            user.profileImageLink != null
                ? Container(
                    decoration: const BoxDecoration(shape: BoxShape.circle),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Hero(
                        tag: "${user.id} profileImage",
                        child: Image.network(
                          user.profileImageLink!,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  )
                : Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Theme.of(context).colorScheme.primaryContainer,
                    ),
                  ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Hero(
                    tag: "${user.id} username",
                    child: Text(
                      user.username ?? "Kein Name",
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
