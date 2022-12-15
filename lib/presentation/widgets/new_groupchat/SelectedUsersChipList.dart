import 'package:flutter/material.dart';
import 'package:social_media_app_flutter/domain/dto/groupchat/create_user_groupchat_dto.dart';

class SelectedUsersChipList extends StatelessWidget {
  final void Function(String userId) onDeleted;
  final List<CreateUserGroupchatWithUsername> groupchatUsersWithUsername;

  const SelectedUsersChipList({
    super.key,
    required this.onDeleted,
    required this.groupchatUsersWithUsername,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: Row(
        children: [
          Expanded(
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Chip(
                  label: Text(groupchatUsersWithUsername[index].username),
                  onDeleted: () =>
                      onDeleted(groupchatUsersWithUsername[index].userId),
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(width: 8);
              },
              itemCount: groupchatUsersWithUsername.length,
            ),
          ),
          const SizedBox(width: 8),
          Text(groupchatUsersWithUsername.length.toString())
        ],
      ),
    );
  }
}
