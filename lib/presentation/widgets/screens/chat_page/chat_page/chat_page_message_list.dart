import 'package:chattyevent_app_flutter/domain/entities/groupchat/groupchat_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:chattyevent_app_flutter/application/bloc/auth/auth_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/current_groupchat/current_chat_cubit.dart';
import 'package:chattyevent_app_flutter/domain/entities/groupchat/groupchat_left_user_entity.dart';
import 'package:chattyevent_app_flutter/domain/entities/groupchat/groupchat_user_entity.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/screens/chat_page/chat_page/chat_page_message_container.dart';

class ChatPageMessageList extends StatefulWidget {
  final String groupchatTo;
  final List<GroupchatUserEntity> users;
  final List<GroupchatLeftUserEntity> leftUsers;
  final List<GroupchatMessageEntity> messages;

  const ChatPageMessageList({
    super.key,
    required this.groupchatTo,
    required this.messages,
    required this.users,
    required this.leftUsers,
  });

  @override
  State<ChatPageMessageList> createState() => _ChatPageMessageListState();
}

class _ChatPageMessageListState extends State<ChatPageMessageList> {
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
    if (_scrollController.position.extentAfter <= 0 &&
        BlocProvider.of<CurrentChatCubit>(context).state.loadingMessages ==
            false) {
      BlocProvider.of<CurrentChatCubit>(context).loadMessages();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GroupedListView<GroupchatMessageEntity, String>(
      controller: _scrollController,
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemBuilder: (context, message) {
        return ChatPageMessageContainer(
          currentUserId:
              BlocProvider.of<AuthCubit>(context).state.currentUser.id,
          message: message,
          users: widget.users,
          leftUsers: widget.leftUsers,
        );
      },
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
