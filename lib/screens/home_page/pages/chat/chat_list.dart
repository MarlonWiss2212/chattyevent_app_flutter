import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:social_media_app_flutter/models/mini_groupchat.dart';
import 'package:social_media_app_flutter/screens/chat_page/chat_page.dart';

class ChatList extends StatelessWidget {
  const ChatList({super.key});

  @override
  Widget build(BuildContext context) {
    return Query(
      options: QueryOptions(document: gql("""
          query {
            findGroupchats {
              _id
              title
              description
            }
          }
          """)),
      builder: (result, {fetchMore, refetch}) {
        if (result.hasException) {
          return Text('Error: ${result.hasException}');
        }

        if (result.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        final groupchatListUnconverted = result.data!["findGroupchats"];
        final List<MiniGroupchat> groupchatList = [];
        for (var miniGroupchat in groupchatListUnconverted) {
          groupchatList.add(
            MiniGroupchat(
              miniGroupchat["_id"],
              miniGroupchat["title"],
              miniGroupchat["description"],
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(8),
          itemBuilder: (context, index) {
            return ListTile(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(5),
                ),
              ),
              title: Text(groupchatList[index].title),
              onTap: () {
                Navigator.pushNamed(
                  context,
                  ChatPage.routeName,
                  arguments: groupchatList[index],
                );
              },
            );
          },
          itemCount: groupchatList.length,
        );
      },
    );
  }
}
