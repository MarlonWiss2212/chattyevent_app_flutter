import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:social_media_app_flutter/infastructure/models/chat_message_model.dart';
import 'package:social_media_app_flutter/presentation/widgets/message_container.dart';

class MessageList extends StatefulWidget {
  final String groupchatId;
  const MessageList(this.groupchatId, {super.key});

  @override
  State<MessageList> createState() => _MessageListState();
}

class _MessageListState extends State<MessageList> {
  final _messagesListController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Query(
      options: QueryOptions(
        document: gql(
          """
            query FindMessages(\$filter: FindMessagesInput!) {
              findMessages(filter: \$filter) {
                _id
                message
                createdBy
                createdAt
              }
            }
          """,
        ),
        variables: {
          "filter": {"groupchatTo": widget.groupchatId}
        },
      ),
      builder: (result, {fetchMore, refetch}) {
        if (result.hasException) {
          print(result.exception);
          return const Text('Konnte deine Chats nicht Laden');
        }

        if (result.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        final messageListUnconverted = result.data!["findMessages"];
        final List<ChatMessageModel> messageList = [];
        for (var message in messageListUnconverted) {
          messageList.add(ChatMessageModel.fromJson(message));
        }

        final messageListWidget = ListView.separated(
          padding: const EdgeInsets.only(top: 8),
          controller: _messagesListController,
          itemBuilder: (context, index) {
            return MessageContainer(
              title: messageList[index].createdBy,
              date: messageList[index].createdAt,
              subtitle: messageList[index].message,
            );
          },
          itemCount: messageList.length,
          separatorBuilder: (BuildContext context, int index) {
            return const SizedBox(height: 8);
          },
        );
        if (_messagesListController.hasClients) {
          _messagesListController
              .jumpTo(_messagesListController.position.maxScrollExtent);
        }
        return messageListWidget;
      },
    );
  }
}
