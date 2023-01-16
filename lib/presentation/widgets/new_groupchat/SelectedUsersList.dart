import 'package:flutter/material.dart';
import 'package:social_media_app_flutter/domain/dto/groupchat/create_user_groupchat_dto.dart';
import 'package:social_media_app_flutter/presentation/widgets/image_with_label_button.dart';

class SelectedUsersList extends StatelessWidget {
  final void Function(String userId) onDeleted;
  final List<CreateUserGroupchatWithUsernameAndImageLink>
      groupchatUsersWithUsername;

  const SelectedUsersList({
    super.key,
    required this.onDeleted,
    required this.groupchatUsersWithUsername,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 100,
      child: Row(
        children: [
          Expanded(
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return SizedBox(
                  width: 100,
                  height: 100,
                  child: ImageWithLabelButton(
                    label: groupchatUsersWithUsername[index].username,
                    imageLink: groupchatUsersWithUsername[index].imageLink,
                    onTap: () => onDeleted(
                      groupchatUsersWithUsername[index].userId,
                    ),
                  ),
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
