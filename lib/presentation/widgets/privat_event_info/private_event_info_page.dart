import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:social_media_app_flutter/application/bloc/chat/chat_bloc.dart';
import 'package:social_media_app_flutter/domain/entities/groupchat/groupchat_entity.dart';
import 'package:social_media_app_flutter/domain/entities/groupchat/groupchat_user_entity.dart';
import 'package:social_media_app_flutter/domain/entities/private_event_entity.dart';
import 'package:social_media_app_flutter/presentation/widgets/divider.dart';
import 'package:social_media_app_flutter/presentation/widgets/privat_event_info/user_list_private_event.dart';

class PrivateEventInfoPage extends StatelessWidget {
  final PrivateEventEntity privateEvent;
  const PrivateEventInfoPage({super.key, required this.privateEvent});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          // Profile Image
          SizedBox(
            width: size.width,
            height: 300,
            child: Card(
              color: Theme.of(context).colorScheme.secondaryContainer,
            ),
          ),
          const SizedBox(height: 20),
          // name
          Text(
            privateEvent.title ?? "Kein Titel",
            style: Theme.of(context).textTheme.titleLarge,
            overflow: TextOverflow.ellipsis,
          ),
          const CustomDivider(),
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
                  invitedUsers = chat.users;
                }
              }
            }

            return UserListPrivateEvent(
              privateEventUserIdsThatWillBeThere:
                  privateEvent.usersThatWillBeThere ?? [],
              privateEventUserIdsThatWillNotBeThere:
                  privateEvent.usersThatWillNotBeThere ?? [],
              invitedUsers: invitedUsers,
            );
          }),
          const CustomDivider(),
          // event date
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Event Datum: ",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(DateFormat.yMd().add_jm().format(privateEvent.eventDate))
            ],
          )
        ],
      ),
    );
  }
}
