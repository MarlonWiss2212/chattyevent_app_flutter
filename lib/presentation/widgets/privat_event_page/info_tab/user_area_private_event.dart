import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app_flutter/application/bloc/chat/chat_cubit.dart';
import 'package:social_media_app_flutter/domain/entities/groupchat/groupchat_user_entity.dart';
import 'package:social_media_app_flutter/domain/entities/private_event_entity.dart';
import 'package:social_media_app_flutter/presentation/widgets/privat_event_page/info_tab/private_event_info_tab_user_list.dart';

class UserAreaPrivateEvent extends StatelessWidget {
  final PrivateEventEntity privateEvent;
  const UserAreaPrivateEvent({super.key, required this.privateEvent});

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
        BlocBuilder<ChatCubit, ChatState>(
          builder: (context, state) {
            List<GroupchatUserEntity> invitedUsers = [];
            if (state is ChatLoaded &&
                privateEvent.connectedGroupchat != null) {
              for (final chat in state.chats) {
                if (chat.id == privateEvent.connectedGroupchat &&
                    chat.users != null) {
                  for (final chatUser in chat.users!) {
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

            return Column(
              children: [
                if (privateEvent.usersThatWillBeThere != null) ...[
                  Text(
                    "Mitglieder die da sein werden: ${privateEvent.usersThatWillBeThere!.length.toString()}",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  if (privateEvent.usersThatWillBeThere!.isNotEmpty ||
                      invitedUsers.isNotEmpty ||
                      privateEvent.usersThatWillNotBeThere != null &&
                          privateEvent.usersThatWillNotBeThere!.isNotEmpty) ...{
                    const SizedBox(height: 8)
                  }
                ],
                PrivateEventInfoTabUserList(
                  privateEventId: privateEvent.id,
                  privateEventUserIdsThatWillBeThere:
                      privateEvent.usersThatWillBeThere ?? [],
                  privateEventUserIdsThatWillNotBeThere:
                      privateEvent.usersThatWillNotBeThere ?? [],
                  invitedUsers: invitedUsers,
                )
              ],
            );
          },
        ),
      ],
    );
  }
}
