import 'package:chattyevent_app_flutter/domain/entities/message/message_entity.dart';
import 'package:chattyevent_app_flutter/domain/entities/user/user_entity.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/custom_divider.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/user_list/user_list_tile.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class ChatMessageBottomDialog extends StatelessWidget {
  final List<UserEntity> users;
  final BuildContext closeContext;
  final Future<void> Function(String id) deleteMessage;
  final String currentUserId;
  final MessageEntity message;

  const ChatMessageBottomDialog({
    super.key,
    required this.deleteMessage,
    required this.users,
    required this.closeContext,
    required this.currentUserId,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    final List<UserEntity> filteredUsers = users.where((element) {
      return message.readBy.contains(element.id);
    }).toList();

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          if (currentUserId == message.createdBy) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "general.deleteText",
                  style: Theme.of(context).textTheme.titleMedium,
                ).tr(),
                IconButton(
                  icon: const Icon(Ionicons.trash),
                  onPressed: () async {
                    await deleteMessage(message.id);
                    // ignore: use_build_context_synchronously
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
            const CustomDivider(),
          ],
          Center(
            child: Text(
              "general.chatMessage.bottomDialog.title",
              style: Theme.of(context).textTheme.titleLarge,
            ).tr(),
          ),
          const SizedBox(height: 20),
          if (filteredUsers.isEmpty) ...{
            Align(
              alignment: Alignment.center,
              child: const Text(
                "general.chatMessage.bottomDialog.emptyMessage",
              ).tr(),
            ),
          } else ...{
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
          },
        ],
      ),
    );
  }
}
