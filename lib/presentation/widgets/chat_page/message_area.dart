import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:social_media_app_flutter/application/bloc/message/message_bloc.dart';
import 'package:social_media_app_flutter/domain/entities/message/message_entity.dart';
import 'package:social_media_app_flutter/domain/filter/get_messages_filter.dart';
import 'package:social_media_app_flutter/presentation/widgets/message_list.dart';

class MessageArea extends StatelessWidget {
  final String groupchatTo;
  const MessageArea({super.key, required this.groupchatTo});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<MessageBloc, MessageState>(
        bloc: BlocProvider.of<MessageBloc>(context)
          ..add(
            MessageRequestEvent(
              getMessagesFilter: GetMessagesFilter(),
            ),
          ),
        builder: (context, state) {
          if (state is MessageStateLoaded) {
            List<MessageEntity> filteredMessages = [];

            for (final message in state.messages) {
              if (message.groupchatTo != null &&
                  message.groupchatTo == groupchatTo) {
                filteredMessages.add(message);
              }
            }

            return MessageList(
              groupchatTo: groupchatTo,
              messages: filteredMessages,
            );
          } else if (state is MessageStateLoading) {
            return Center(child: PlatformCircularProgressIndicator());
          } else {
            return Center(
              child: PlatformTextButton(
                child: Text(
                  state is MessageStateError ? state.message : "Daten laden",
                ),
                onPressed: () => BlocProvider.of<MessageBloc>(context).add(
                  MessageRequestEvent(
                    getMessagesFilter: GetMessagesFilter(),
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
