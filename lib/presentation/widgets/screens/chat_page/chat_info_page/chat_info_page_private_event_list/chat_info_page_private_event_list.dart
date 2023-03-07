import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletons/skeletons.dart';
import 'package:social_media_app_flutter/application/bloc/chat/current_chat_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/private_event/private_event_cubit.dart';
import 'package:social_media_app_flutter/domain/entities/private_event/private_event_entity.dart';
import 'package:social_media_app_flutter/presentation/widgets/screens/chat_page/chat_info_page/chat_info_page_private_event_list/chat_info_page_private_event_list_item.dart';

class ChatInfoPagePrivateEventList extends StatelessWidget {
  const ChatInfoPagePrivateEventList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrentChatCubit, CurrentChatState>(
      buildWhen: (previous, current) =>
          previous.currentChat.id != current.currentChat.id,
      builder: (context, chatState) {
        return BlocBuilder<PrivateEventCubit, PrivateEventState>(
          builder: (context, state) {
            List<PrivateEventEntity> filteredEvents = state.privateEvents
                .where(
                  (element) =>
                      element.connectedGroupchat == chatState.currentChat.id,
                )
                .toList();

            return Column(
              children: [
                Text(
                  "Private Events: ${filteredEvents.length}",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                if (filteredEvents.isEmpty &&
                    state.status == PrivateEventStateStatus.loading) ...[
                  const SizedBox(height: 8),
                  SkeletonListTile(
                    padding: const EdgeInsets.all(8),
                    hasSubtitle: true,
                    titleStyle: const SkeletonLineStyle(width: 100, height: 22),
                    subtitleStyle: const SkeletonLineStyle(
                      width: double.infinity,
                      height: 16,
                    ),
                    leadingStyle: const SkeletonAvatarStyle(
                      shape: BoxShape.circle,
                    ),
                  ),
                ] else if (filteredEvents.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return ChatInfoPagePrivateEventListItem(
                        privateEvent: filteredEvents[index],
                      );
                    },
                    itemCount: filteredEvents.length,
                  ),
                ]
              ],
            );
          },
        );
      },
    );
  }
}
