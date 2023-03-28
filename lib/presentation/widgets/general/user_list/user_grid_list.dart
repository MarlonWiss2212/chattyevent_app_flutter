import 'dart:math';

import 'package:flutter/material.dart';
import 'package:social_media_app_flutter/domain/entities/user/user_entity.dart';
import 'package:social_media_app_flutter/presentation/widgets/general/user_list/user_grid_list_item.dart';

class UserGridList extends StatelessWidget {
  final List<UserEntity> users;
  final Function(UserEntity user)? onLongPress;
  final Function(UserEntity user)? onPress;
  final Widget Function(UserEntity user)? button;

  const UserGridList({
    super.key,
    required this.users,
    this.button,
    this.onLongPress,
    this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemBuilder: (context, index) {
        return UserGridListItem(
          user: users[index],
          button: button != null ? button!(users[index]) : null,
          onLongPress:
              onLongPress == null ? null : () => onLongPress!(users[index]),
          onPress: onPress == null ? null : () => onPress!(users[index]),
        );
      },
      itemCount: users.length,
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
