import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:chattyevent_app_flutter/domain/entities/user/user_entity.dart';

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
          fit: StackFit.expand,
          children: [
            user.profileImageLink != null
                ? Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Hero(
                        tag: "${user.id} profileImage",
                        child: CachedNetworkImage(
                          imageUrl: user.profileImageLink!,
                          cacheKey: user.profileImageLink!.split("?")[0],
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  )
                : Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Theme.of(context).colorScheme.surface,
                    ),
                  ),
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0x00000000),
                    Color(0x00000000),
                    Color(0xCC000000),
                  ],
                ),
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
                      user.username ?? "",
                      style: Theme.of(context).textTheme.labelMedium?.apply(
                            color: Colors.white,
                          ),
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
