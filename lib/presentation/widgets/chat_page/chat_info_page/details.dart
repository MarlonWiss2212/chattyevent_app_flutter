import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:social_media_app_flutter/application/bloc/auth/auth_bloc.dart';
import 'package:social_media_app_flutter/application/bloc/chat/chat_bloc.dart';
import 'package:social_media_app_flutter/domain/entities/groupchat/groupchat_entity.dart';
import 'package:social_media_app_flutter/domain/entities/groupchat/groupchat_user_entity.dart';
import 'package:social_media_app_flutter/presentation/router/router.gr.dart';
import 'package:social_media_app_flutter/presentation/widgets/chat_page/chat_info_page/private_event_list_groupchat.dart';
import 'package:social_media_app_flutter/presentation/widgets/divider.dart';
import 'package:social_media_app_flutter/presentation/widgets/chat_page/chat_info_page/user_left_list_groupchat.dart';
import 'package:social_media_app_flutter/presentation/widgets/chat_page/chat_info_page/user_list_groupchat.dart';

class Details extends StatelessWidget {
  final GroupchatEntity groupchat;
  const Details({super.key, required this.groupchat});

  @override
  Widget build(BuildContext context) {
    String currentUserId = "";
    final authState = BlocProvider.of<AuthBloc>(context).state;
    if (authState is AuthStateLoaded) {
      currentUserId = Jwt.parseJwt(authState.token)["sub"];
    }
    GroupchatUserEntity? currentGroupchatUser;
    for (final groupchatUser in groupchat.users) {
      if (groupchatUser.userId == currentUserId &&
          groupchatUser.admin != null &&
          groupchatUser.admin == true) {
        currentGroupchatUser = groupchatUser;
      }
    }

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
          Hero(
            tag: "${groupchat.id} title",
            child: Text(
              groupchat.title ?? "Kein Titel",
              style: Theme.of(context).textTheme.titleLarge,
              overflow: TextOverflow.ellipsis,
            ),
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
          // private Events
          PrivateEventListGroupchat(groupchatId: groupchat.id),
          const CustomDivider(),
          // users
          if (groupchat.users.isNotEmpty) ...[
            Text(
              "Midglieder: ${groupchat.users.length}",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            if (currentGroupchatUser != null &&
                currentGroupchatUser.admin != null &&
                currentGroupchatUser.admin == true) ...{
              // add user
              ListTile(
                leading: const Icon(
                  Icons.person_add,
                  color: Colors.green,
                ),
                title: const Text(
                  "User zum Chat hinzufügen",
                  style: TextStyle(color: Colors.green),
                ),
                onTap: () {
                  AutoRouter.of(context).push(
                    ChatAddUserPageRoute(),
                  );
                },
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(5),
                  ),
                ),
              )
            },
            UserListGroupchat(
              groupchatUsers: groupchat.users,
              groupchatId: groupchat.id,
              currentGrouppchatUser: currentGroupchatUser,
            ),
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
          if (groupchat.leftUsers.isNotEmpty) ...{const SizedBox(height: 8)},
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
            onTap: () {
              BlocProvider.of<ChatBloc>(context).add(
                DeleteUserFromChatEvent(
                  groupchatId: groupchat.id,
                  userIdToDelete: currentUserId,
                ),
              );
            },
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
