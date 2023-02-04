import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:social_media_app_flutter/application/bloc/auth/auth_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/chat/current_chat_cubit.dart';
import 'package:social_media_app_flutter/domain/entities/groupchat/groupchat_entity.dart';
import 'package:social_media_app_flutter/domain/entities/groupchat/groupchat_user_entity.dart';
import 'package:social_media_app_flutter/presentation/router/router.gr.dart';
import 'package:social_media_app_flutter/presentation/widgets/chat_page/chat_info_page/private_event_list_groupchat.dart';
import 'package:social_media_app_flutter/presentation/widgets/circle_image/cirlce_image.dart';
import 'package:social_media_app_flutter/presentation/widgets/divider.dart';
import 'package:social_media_app_flutter/presentation/widgets/chat_page/chat_info_page/user_left_list_groupchat.dart';
import 'package:social_media_app_flutter/presentation/widgets/chat_page/chat_info_page/user_list_groupchat.dart';

class ChatInfoPageDetails extends StatelessWidget {
  final GroupchatEntity groupchat;
  const ChatInfoPageDetails({super.key, required this.groupchat});

  @override
  Widget build(BuildContext context) {
    final currentUserId = Jwt.parseJwt(
        (BlocProvider.of<AuthCubit>(context).state as AuthLoaded).token)["sub"];
    GroupchatUserEntity? currentGroupchatUser;
    if (groupchat.users != null) {
      for (final groupchatUser in groupchat.users!) {
        if (groupchatUser.userId == currentUserId &&
            groupchatUser.admin != null &&
            groupchatUser.admin == true) {
          currentGroupchatUser = groupchatUser;
        }
      }
    }

    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 20),
          // Groupchat Image
          CircleImage(
            imageLink: groupchat.profileImageLink,
          ),
          const SizedBox(height: 20),
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
          if (groupchat.users != null) ...[
            Text(
              "Midglieder: ${groupchat.users!.length}",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            if (groupchat.users!.isNotEmpty) ...{const SizedBox(height: 8)},
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
              )
            },
            UserListGroupchat(
              groupchatUsers: groupchat.users!,
              groupchatId: groupchat.id,
              currentGrouppchatUser: currentGroupchatUser,
            ),
          ] else ...[
            Text(
              "Konnte die Gruppenchat Benutzer nicht Laden",
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
          const CustomDivider(),
          // left users
          if (groupchat.leftUsers != null) ...[
            Text(
              "Frühere Midglieder: ${groupchat.leftUsers!.length}",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            if (groupchat.leftUsers!.isNotEmpty) ...{const SizedBox(height: 8)},
            UserLeftListGroupchat(
              groupchatLeftUsers: groupchat.leftUsers!,
              currentGrouppchatUser: currentGroupchatUser,
              groupchatId: groupchat.id,
            ),
          ] else ...[
            Text(
              "Konnte die Früheren Mitglieder nicht Laden",
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
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
              BlocProvider.of<CurrentChatCubit>(context)
                  .deleteUserFromChatEvent(
                groupchatId: groupchat.id,
                userIdToDelete: currentUserId,
              );
            },
          )
        ],
      ),
    );
  }
}