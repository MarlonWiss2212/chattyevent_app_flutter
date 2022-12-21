import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app_flutter/application/bloc/private_event/private_event_bloc.dart';
import 'package:social_media_app_flutter/domain/entities/private_event_entity.dart';
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

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            children: [
              MessageArea(
                groupchatTo: foundPrivateEvent.connectedGroupchat!,
              ),
              const SizedBox(height: 8),
              MessageInput(
                groupchatTo: foundPrivateEvent.connectedGroupchat!,
              ),
              const SizedBox(height: 8),
            ],
          ),
        );
      },
    );
  }
}
