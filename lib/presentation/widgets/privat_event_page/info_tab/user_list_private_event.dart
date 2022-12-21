import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app_flutter/application/bloc/chat/chat_bloc.dart';
import 'package:social_media_app_flutter/domain/entities/groupchat/groupchat_user_entity.dart';
import 'package:social_media_app_flutter/domain/entities/private_event_entity.dart';
import 'package:social_media_app_flutter/presentation/widgets/divider.dart';
import 'package:social_media_app_flutter/presentation/widgets/privat_event_page/info_tab/list_of_all_users_for_private_event.dart';

class UserListPrivateEvent extends StatelessWidget {
  final PrivateEventEntity privateEvent;
  const UserListPrivateEvent({super.key, required this.privateEvent});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (privateEvent.usersThatWillBeThere == null) ...{
          const Text(
            "Fehler beim darstellen der User die da sein werden",
            softWrap: true,
            overflow: TextOverflow.ellipsis,
          ),
        },
        if (privateEvent.connectedGroupchat == null) ...{
          const Text(
            "Fehler beim darstellen der User die eingeladen sind",
            softWrap: true,
            overflow: TextOverflow.ellipsis,
          ),
        },
        if (privateEvent.usersThatWillNotBeThere == null) ...{
          const Text(
            "Fehler beim darstellen der User die nicht da sein werden",
            softWrap: true,
            overflow: TextOverflow.ellipsis,
          ),
        },
        BlocBuilder<ChatBloc, ChatState>(builder: (context, state) {
          List<GroupchatUserEntity> invitedUsers = [];
          if (state is ChatStateLoaded &&
              privateEvent.connectedGroupchat != null) {
            for (final chat in state.chats) {
              if (chat.id == privateEvent.connectedGroupchat) {
                for (final chatUser in chat.users) {
                  bool pushUser = true;

                  // to check if user already accapted invitation
                  if (privateEvent.usersThatWillBeThere != null) {
                    for (final userThatWillBeThere
                        in privateEvent.usersThatWillBeThere!) {
                      if (userThatWillBeThere == chatUser.userId) {
                        pushUser = false;
                      }
                    }
                  }

                  // to check if user already declined invitation
                  if (privateEvent.usersThatWillNotBeThere != null) {
                    for (final userThatWillNotBeThere
                        in privateEvent.usersThatWillNotBeThere!) {
                      if (userThatWillNotBeThere == chatUser.userId) {
                        pushUser = false;
                      }
                    }
                  }

                  if (pushUser) {
                    invitedUsers.add(chatUser);
                  }
                }
                break;
              }
            }
          }

          return ListOfAllUsersForPrivateEvent(
            privateEventUserIdsThatWillBeThere:
                privateEvent.usersThatWillBeThere ?? [],
            privateEventUserIdsThatWillNotBeThere:
                privateEvent.usersThatWillNotBeThere ?? [],
            invitedUsers: invitedUsers,
          );
        }),
      ],
    );
  }
}
