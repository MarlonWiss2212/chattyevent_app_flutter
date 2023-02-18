import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletons/skeletons.dart';
import 'package:social_media_app_flutter/application/bloc/message/message_cubit.dart';
import 'package:social_media_app_flutter/domain/entities/message/message_entity.dart';
import 'package:social_media_app_flutter/presentation/widgets/message_list.dart';

class MessageArea extends StatelessWidget {
  final String groupchatTo;
  const MessageArea({super.key, required this.groupchatTo});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<MessageCubit, MessageState>(
        builder: (context, state) {
          bool loadingDataForCurrentEvent = state is MessageLoading &&
              state.loadingForGroupchatId == groupchatTo;

          const emptyReturn = Center(child: Text("Keine Nachrichten"));

          if (state.messages.isEmpty && !loadingDataForCurrentEvent) {
            return emptyReturn;
          }

          List<MessageEntity> filteredMessages = [];

          for (final message in state.messages) {
            if (message.groupchatTo == groupchatTo) {
              filteredMessages.add(message);
            }
          }

          if (filteredMessages.isEmpty && loadingDataForCurrentEvent) {
            return SkeletonListView(
              itemBuilder: (p0, p1) {
                return SkeletonListTile(
                  hasSubtitle: true,
                  hasLeading: false,
                  titleStyle: const SkeletonLineStyle(
                    width: double.infinity,
                    height: 22,
                  ),
                  subtitleStyle: const SkeletonLineStyle(
                    width: double.infinity,
                    height: 16,
                  ),
                );
              },
            );
          }

          if (filteredMessages.isEmpty) {
            return emptyReturn;
          }

          return MessageList(
            groupchatTo: groupchatTo,
            messages: filteredMessages,
          );
        },
      ),
    );
  }
}
