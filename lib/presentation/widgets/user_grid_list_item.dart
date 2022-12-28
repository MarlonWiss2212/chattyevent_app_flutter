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
        child: Card(
          color: Theme.of(context).colorScheme.secondaryContainer,
          elevation: 0,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(),
                CircleAvatar(
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                ),
                Hero(
                  tag: "${user.id} username",
                  child: Text(
                    user.username ?? "Kein Name",
                    style: Theme.of(context).textTheme.labelMedium,
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                  ),
                ),
                if (button != null) ...{button!},
              ],
            ),
          ),
        ),
      ),
    );
  }
}
