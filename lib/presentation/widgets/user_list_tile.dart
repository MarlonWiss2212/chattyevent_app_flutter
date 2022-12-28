import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app_flutter/presentation/router/router.gr.dart';

class UserListTile extends StatelessWidget {
  final String userId;
  final String username;
  final Widget? subtitle;
  final Widget? trailing;
  final Function(String userId)? longPress;
  // image
  const UserListTile({
    super.key,
    this.subtitle,
    required this.username,
    required this.userId,
    this.trailing,
    this.longPress,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(5),
        ),
      ),
      title: Hero(
        tag: "$userId username",
        child: Text(
          username,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      subtitle: subtitle,
      onTap: () {
        AutoRouter.of(context).root.push(
              ProfilePageRoute(
                userId: userId,
              ),
            );
      },
      onLongPress: longPress != null ? () => longPress!(userId) : null,
      trailing: trailing,
    );
  }
}
