import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app_flutter/domain/entities/user_entity.dart';
import 'package:social_media_app_flutter/presentation/router/router.gr.dart';

class UserListTile extends StatelessWidget {
  final String? customTitle;
  final UserEntity user;
  final Widget? subtitle;
  final Widget? trailing;
  final Function(UserEntity user)? longPress;

  const UserListTile({
    super.key,
    this.customTitle,
    this.subtitle,
    required this.user,
    this.trailing,
    this.longPress,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: user.profileImageLink != null
            ? NetworkImage(user.profileImageLink!)
            : null,
        backgroundColor: user.profileImageLink == null
            ? Theme.of(context).colorScheme.secondaryContainer
            : null,
      ),
      title: Hero(
        tag: "${user.id} username",
        child: Text(
          customTitle ?? user.username ?? "Kein Username",
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      subtitle: subtitle,
      onTap: () {
        AutoRouter.of(context).root.push(
              ProfilePageRoute(
                  userId: user.id, loadUserFromApiToo: true, userToSet: user),
            );
      },
      onLongPress: longPress != null ? () => longPress!(user) : null,
      trailing: trailing,
    );
  }
}
