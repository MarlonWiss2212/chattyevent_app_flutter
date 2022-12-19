import 'dart:math';

import 'package:flutter/material.dart';
import 'package:social_media_app_flutter/domain/entities/user_entity.dart';
import 'package:social_media_app_flutter/presentation/widgets/user_grid_list_item.dart';

class UserGridList extends StatelessWidget {
  final List<UserEntity> users;
  final Function(UserEntity user)? onLongPress;
  final Function(UserEntity user)? onPress;
  const UserGridList({
    super.key,
    required this.users,
    this.onLongPress,
    this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemBuilder: (context, index) {
        return UserGridListItem(
          user: users[index],
          onLongPress: onLongPress == null
              ? null
              : () {
                  onLongPress!(users[index]);
                },
          onPress: onPress == null
              ? null
              : () {
                  onPress!(users[index]);
                },
        );
      },
      itemCount: users.length,
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
