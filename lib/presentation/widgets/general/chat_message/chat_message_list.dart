import 'package:chattyevent_app_flutter/domain/entities/message/message_entity.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';

class ChatMessageList extends StatefulWidget {
  final Widget Function(BuildContext, MessageEntity)? itemBuilder;
  final List<MessageEntity> messages;
  final void Function() loadMoreMessages;

  const ChatMessageList({
    super.key,
    required this.messages,
    required this.itemBuilder,
    required this.loadMoreMessages,
  });

  @override
  State<ChatMessageList> createState() => _ChatMessageListState();
}

class _ChatMessageListState extends State<ChatMessageList> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.extentAfter <= 0) {
      widget.loadMoreMessages();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GroupedListView<MessageEntity, String>(
      controller: _scrollController,
      padding: const EdgeInsets.symmetric(vertical: 4),
      itemBuilder: widget.itemBuilder,
      elements: widget.messages,
      useStickyGroupSeparators: true,
      physics: const ClampingScrollPhysics(),
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
                borderRadius: BorderRadius.circular(8),
                color: Theme.of(context).colorScheme.surface,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Text(DateFormat.yMMMd().format(messageEntity.createdAt)),
              ),
            ),
          ),
        );
      },
      groupSeparatorBuilder: (_) => const SizedBox(height: 8),
      separator: const SizedBox(height: 8),
    );
  }
}
