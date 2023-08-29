import 'package:chattyevent_app_flutter/domain/entities/user/user_entity.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/dialog/bottom_blurred_surface_dialog.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/user_list/user_list_tile.dart';
import 'package:flutter/material.dart';

class ChatMessageReadByBottomDialog extends StatelessWidget {
  final List<UserEntity> users;
  final BuildContext closeContext;
  final List<String> readByIds;

  const ChatMessageReadByBottomDialog({
    super.key,
    required this.readByIds,
    required this.users,
    required this.closeContext,
  });

  @override
  Widget build(BuildContext context) {
    final List<UserEntity> filteredUsers = users.where((element) {
      return readByIds.contains(element.id);
    }).toList();

    if (filteredUsers.isEmpty) {
      return const Center(child: Text("Keiner hat die Nachticht gelesen"));
    }
    return BottomBlurredSurfaceDialog(
      child: Column(
        children: [
          Center(
            child: Text(
              "Gelesen von:",
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          Flexible(
            child: ListView.builder(
              shrinkWrap: true,
              itemBuilder: (context, index) => UserListTile(
                key: ObjectKey(filteredUsers[index]),
                user: filteredUsers[index],
                onTapAdditionalLogic: () => Navigator.of(closeContext).pop(),
              ),
              itemCount: filteredUsers.length,
            ),
          ),
        ],
      ),
    );
  }
}
