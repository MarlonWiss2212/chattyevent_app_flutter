import 'package:flutter/material.dart';
import 'package:social_media_app_flutter/domain/dto/groupchat/create_groupchat_user_dto.dart';
import 'package:social_media_app_flutter/domain/dto/groupchat/create_groupchat_user_from_create_groupchat_dto.dart';
import 'package:social_media_app_flutter/presentation/widgets/image_with_label_button.dart';

class SelectedUsersList extends StatelessWidget {
  final void Function(String userId) onDeleted;
  final List<CreateGroupchatUserFromCreateGroupchatDtoWithUsernameAndLink>
      groupchatUsers;

  const SelectedUsersList({
    super.key,
    required this.onDeleted,
    required this.groupchatUsers,
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
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return SizedBox(
                  width: 100,
                  height: 100,
                  child: ImageWithLabelButton(
                    label: groupchatUsers[index].username,
                    imageLink: groupchatUsers[index].imageLink,
                    onTap: () => onDeleted(
                      groupchatUsers[index].userId,
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(width: 8);
              },
              itemCount: groupchatUsers.length,
            ),
          ),
          const SizedBox(width: 8),
          Text(groupchatUsers.length.toString())
        ],
      ),
    );
  }
}
