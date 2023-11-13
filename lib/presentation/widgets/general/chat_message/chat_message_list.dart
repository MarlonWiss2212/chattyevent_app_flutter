import 'package:chattyevent_app_flutter/core/enums/message/message_type_enum.dart';
import 'package:chattyevent_app_flutter/domain/entities/message/message_entity.dart';
import 'package:chattyevent_app_flutter/domain/entities/user/user_entity.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/chat_message/chat_message_container.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/chat_message/chat_message_notification_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';

class ChatMessageList extends StatefulWidget {
  final List<MessageEntity> messages;
  final List<UserEntity> users;
  final int usersCount;
  final String currentUserId;
  final Future<void> Function() loadMoreMessages;
  final Future<void> Function(String id) deleteMessage;

  const ChatMessageList({
    super.key,
    required this.messages,
    required this.currentUserId,
    required this.users,
    required this.deleteMessage,
    required this.usersCount,
    required this.loadMoreMessages,
  });

  @override
  State<ChatMessageList> createState() => _ChatMessageListState();
}

class _ChatMessageListState extends State<ChatMessageList> {
  bool loadMore = false;
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _scrollListener() async {
    if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent &&
        !loadMore) {
      loadMore = true;
      widget.loadMoreMessages().then((_) => loadMore = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GroupedListView<MessageEntity, String>(
      cacheExtent: 500,
      key: widget.key,
      controller: _scrollController,
      padding: const EdgeInsets.symmetric(vertical: 4),
      itemBuilder: (context, message) {
        return Padding(
          padding: message.id == widget.messages.first.id
              ? const EdgeInsets.only(bottom: 60)
              : const EdgeInsets.all(0),
          child: message.type != MessageTypeEnum.defaultMessage
              ? ChatMessageNotificationContainer(
                  key: Key(message.id),
                  deleteMessage: widget.deleteMessage,
                  users: widget.users,
                  usersCount: widget.usersCount,
                  message: message,
                  currentUserId: widget.currentUserId,
                )
              : ChatMessageContainer(
                  key: Key(message.id),
                  deleteMessage: widget.deleteMessage,
                  users: widget.users,
                  usersCount: widget.usersCount,
                  message: message,
                  currentUserId: widget.currentUserId,
                )
                  .animate(
                      key: widget.messages.first.id == message.id
                          ? ObjectKey(message)
                          : null)
                  .move(
                    curve: Curves.easeInOutCirc,
                    duration: const Duration(milliseconds: 600),
                    begin: message.createdBy == widget.currentUserId
                        ? const Offset(200, 400)
                        : const Offset(-200, 400),
                    end: const Offset(0, 0),
                  ),
        );
      },
      elements: widget.messages,
      useStickyGroupSeparators: true,
      reverse: true,
      sort: false,
      order: GroupedListOrder.DESC,
      floatingHeader: true,
      groupBy: (messageEntity) {
        return DateTime(
          messageEntity.createdAt.year,
          messageEntity.createdAt.month,
          messageEntity.createdAt.day,
        ).toString();
      },
      groupHeaderBuilder: (messageEntity) {
        return SizedBox(
          height: 40,
          child: Center(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Theme.of(context).colorScheme.surface,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  DateFormat.yMMMd().format(messageEntity.createdAt),
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ),
            ),
          ),
        );
      },
      groupSeparatorBuilder: (_) => const SizedBox(height: 8),
      separator: const SizedBox(height: 12),
    );
  }
}
