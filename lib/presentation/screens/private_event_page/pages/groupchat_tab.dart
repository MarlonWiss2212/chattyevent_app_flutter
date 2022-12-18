import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:social_media_app_flutter/application/bloc/chat/chat_bloc.dart';
import 'package:social_media_app_flutter/application/bloc/message/message_bloc.dart';
import 'package:social_media_app_flutter/application/bloc/private_event/private_event_bloc.dart';
import 'package:social_media_app_flutter/application/bloc/user/user_bloc.dart';
import 'package:social_media_app_flutter/domain/entities/groupchat/groupchat_entity.dart';
import 'package:social_media_app_flutter/domain/entities/private_event_entity.dart';
import 'package:social_media_app_flutter/domain/filter/get_messages_filter.dart';
import 'package:social_media_app_flutter/presentation/widgets/chat_page/message_area.dart';
import 'package:social_media_app_flutter/presentation/widgets/chat_page/message_input.dart';

class GroupchatTab extends StatelessWidget {
  final String privateEventId;
  const GroupchatTab({
    super.key,
    @PathParam('id') required this.privateEventId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PrivateEventBloc, PrivateEventState>(
      builder: (context, state) {
        PrivateEventEntity? foundPrivateEvent;
        if (state is PrivateEventStateLoaded) {
          for (final privateEvent in state.privateEvents) {
            if (privateEvent.id == privateEventId) {
              foundPrivateEvent = privateEvent;
            }
          }
        }

        if (foundPrivateEvent == null) {
          return const Expanded(
            child: Center(child: Text("Privates Event nicht gefunden")),
          );
        }

        if (foundPrivateEvent.connectedGroupchat == null) {
          return const Center(
            child: Text("Kein Gruppenchat für dieses Event gefunden"),
          );
        }

        return BlocBuilder<ChatBloc, ChatState>(builder: (context, state) {
          if (state is ChatStateLoaded) {
            GroupchatEntity foundGroupchat = GroupchatEntity(
              id: "",
              users: [],
              leftUsers: [],
            );

            for (final groupchat in state.chats) {
              if (groupchat.id == foundPrivateEvent!.connectedGroupchat) {
                foundGroupchat = groupchat;
                break;
              }
            }

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                children: [
                  MessageArea(groupchatTo: foundGroupchat.id),
                  const SizedBox(height: 8),
                  MessageInput(groupchatTo: foundGroupchat.id),
                  const SizedBox(height: 8),
                ],
              ),
            );
          } else if (state is ChatStateLoading) {
            return Center(
              child: PlatformCircularProgressIndicator(),
            );
          } else {
            return Center(
              child: PlatformTextButton(
                child: Text(
                  state is ChatStateError ? state.message : "Daten laden",
                ),
                onPressed: () => BlocProvider.of<ChatBloc>(context).add(
                  ChatRequestEvent(),
                ),
              ),
            );
          }
        });
      },
    );
  }
}
