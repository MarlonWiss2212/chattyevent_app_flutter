import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app_flutter/domain/entities/user_entity.dart';
import 'package:social_media_app_flutter/presentation/router/router.gr.dart';

class UserListTile extends StatelessWidget {
  final String userId;
  final String username;
  final String? profileImageLink;
  final Widget? subtitle;
  final Widget? trailing;
  final Function(String userId)? longPress;

  const UserListTile({
    super.key,
    this.subtitle,
    required this.username,
    required this.userId,
    this.profileImageLink,
    this.trailing,
    this.longPress,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage:
            profileImageLink != null ? NetworkImage(profileImageLink!) : null,
        backgroundColor: profileImageLink == null
            ? Theme.of(context).colorScheme.secondaryContainer
            : null,
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
                loadUserFromApiToo: true,
                userToSet: UserEntity(
                  id: userId,
                  username: username,
                  profileImageLink: profileImageLink,
                ),
              ),
            );
      },
      onLongPress: longPress != null ? () => longPress!(userId) : null,
      trailing: trailing,
    );
  }
}