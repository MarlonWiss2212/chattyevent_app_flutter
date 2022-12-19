import 'package:flutter/material.dart';
import 'package:social_media_app_flutter/domain/entities/groupchat/groupchat_entity.dart';
import 'package:social_media_app_flutter/presentation/widgets/divider.dart';
import 'package:social_media_app_flutter/presentation/widgets/chat_page/chat_info_page/user_left_list_groupchat.dart';
import 'package:social_media_app_flutter/presentation/widgets/chat_page/chat_info_page/user_list_groupchat.dart';

class Details extends StatelessWidget {
  final GroupchatEntity groupchat;
  const Details({super.key, required this.groupchat});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          const SizedBox(height: 40),
          // Groupchat Image
          CircleAvatar(
            backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
          ),
          const SizedBox(height: 20),
          // name
          Text(
            groupchat.title ?? "Kein Titel",
            style: Theme.of(context).textTheme.titleLarge,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 12),
          // description
          Text(
            groupchat.description == null ||
                    groupchat.description != null &&
                        groupchat.description!.isEmpty
                ? "Keine Beschreibung"
                : groupchat.description!,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const CustomDivider(),
          // users
          if (groupchat.users.isNotEmpty) ...[
            Text(
              "Midglieder: ${groupchat.users.length}",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            UserListGroupchat(groupchatUsers: groupchat.users),
          ] else ...[
            Text(
              "Fehler beim darstellen der Gruppenchat Benutzer",
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.titleMedium,
            )
          ],
          const CustomDivider(),
          // left users
          Text(
            "Frühere Midglieder: ${groupchat.leftUsers.length}",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          UserLeftListGroupchat(groupchatLeftUsers: groupchat.leftUsers),
          const CustomDivider(),
          // leave Chat Button
          ListTile(
            leading: const Icon(
              Icons.logout,
              color: Colors.red,
            ),
            title: const Text(
              "Gruppenchat verlassen",
              style: TextStyle(color: Colors.red),
            ),
            onTap: () {},
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(5),
              ),
            ),
          )
        ],
      ),
    );
  }
}
