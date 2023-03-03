import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:social_media_app_flutter/application/bloc/auth/auth_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/chat/current_chat_cubit.dart';
import 'package:social_media_app_flutter/core/injection.dart';
import 'package:social_media_app_flutter/domain/entities/groupchat/user_with_groupchat_user_data.dart';
import 'package:social_media_app_flutter/domain/entities/groupchat/user_with_left_groupchat_user_data.dart';
import 'package:social_media_app_flutter/domain/entities/message/message_entity.dart';
import 'package:social_media_app_flutter/presentation/widgets/screens/chat_page/chat_page/chat_page_message_container.dart';

class ChatPageMessageList extends StatefulWidget {
  final String groupchatTo;
  final List<UserWithGroupchatUserData> usersWithGroupchatUserData;
  final List<UserWithLeftGroupchatUserData> usersWithLeftGroupchatUserData;
  final List<MessageEntity> messages;

  const ChatPageMessageList({
    super.key,
    required this.groupchatTo,
    required this.messages,
    required this.usersWithGroupchatUserData,
    required this.usersWithLeftGroupchatUserData,
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
    if (_scrollController.position.extentAfter <= 0) {
      BlocProvider.of<CurrentChatCubit>(context).loadMessages();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GroupedListView<MessageEntity, String>(
      controller: _scrollController,
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemBuilder: (context, message) {
        return ChatPageMessageContainer(
          currentUserId: serviceLocator<FirebaseAuth>().currentUser?.uid ?? "",
          message: message,
          usersWithGroupchatUserData: widget.usersWithGroupchatUserData,
          usersWithLeftGroupchatUserData: widget.usersWithLeftGroupchatUserData,
        );
      },
      elements: widget.messages,
      useStickyGroupSeparators: true,
      reverse: true,
      sort: false,
      order: GroupedListOrder.DESC,
      floatingHeader: true,
      groupBy: (messageEntity) {
        if (messageEntity.createdAt == null) {
          return "Fehler";
        }
        return DateTime(
          messageEntity.createdAt!.year,
          messageEntity.createdAt!.month,
          messageEntity.createdAt!.day,
        ).toString();
      },
      groupHeaderBuilder: (messageEntity) {
        return SizedBox(
          height: 40,
          child: Center(
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  messageEntity.createdAt == null
                      ? "Kein Datum gefunden"
                      : DateFormat.yMMMd().format(messageEntity.createdAt!),
                ),
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
