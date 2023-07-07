import 'package:chattyevent_app_flutter/domain/entities/user/user_entity.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/user_list/user_list_tile.dart';
import 'package:flutter/material.dart';

class ChatMessageReadByBottomSheet extends StatelessWidget {
  final List<UserEntity> users;
  final List<String> readByIds;

  const ChatMessageReadByBottomSheet({
    super.key,
    required this.readByIds,
    required this.users,
  });

  @override
  Widget build(BuildContext context) {
    final List<UserEntity> filteredUsers = users.where((element) {
      return readByIds.contains(element.id);
    }).toList();

    if (filteredUsers.isEmpty) {
      return const Center(child: Text("Keiner hat die Nachticht gelesen"));
    }
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: Text(
              "Gelesen von:",
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
        ),
        Flexible(
          child: ListView.builder(
            shrinkWrap: true,
            itemBuilder: (context, index) => UserListTile(
              user: filteredUsers[index],
            ),
            itemCount: filteredUsers.length,
          ),
        ),
      ],
    );
  }
}
