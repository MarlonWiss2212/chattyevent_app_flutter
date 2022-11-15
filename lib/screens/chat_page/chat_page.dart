import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:social_media_app_flutter/models/mini_groupchat.dart';
import 'package:social_media_app_flutter/models/mini_messages.dart';
import 'package:social_media_app_flutter/screens/chat_page/message_container.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});
  static const routeName = '/chat';

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final _messagesListController = ScrollController();
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as MiniGroupchat;

    return Scaffold(
      appBar: AppBar(
        title: Text(args.title),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              Expanded(
                child: Query(
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
                      "filter": {"groupchatTo": args.id}
                    },
                  ),
                  builder: (result, {fetchMore, refetch}) {
                    if (result.hasException) {
                      print(result.exception);
                      return Text('Error: ${result.hasException}');
                    }

                    if (result.isLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    final messageListUnconverted = result.data!["findMessages"];
                    final List<MiniMessage> messageList = [];
                    for (var miniMessage in messageListUnconverted) {
                      messageList.add(
                        MiniMessage(
                          miniMessage["_id"],
                          miniMessage["message"],
                          miniMessage["createdBy"],
                          miniMessage["createdAt"],
                        ),
                      );
                    }

                    final messageListWidget = ListView.separated(
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
                    // for auto scrolling down
                    if (_messagesListController.hasClients) {
                      _messagesListController.jumpTo(
                          _messagesListController.position.maxScrollExtent);
                    }
                    return messageListWidget;
                  },
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 8),
                    SizedBox(
                      height: 50,
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              alignment: Alignment.center,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                              ),
                              decoration: BoxDecoration(
                                color: Theme.of(context).cardColor,
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: const TextField(
                                decoration: InputDecoration.collapsed(
                                  hintText: 'Nachricht',
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          TextButton(
                            style: ButtonStyle(
                              shape: MaterialStateProperty.resolveWith(
                                (states) => const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(8),
                                  ),
                                ),
                              ),
                              backgroundColor:
                                  MaterialStateProperty.resolveWith((states) =>
                                      Theme.of(context)
                                          .colorScheme
                                          .primaryContainer),
                            ),
                            onPressed: () {},
                            child: const Center(
                              child: Icon(Icons.send),
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
