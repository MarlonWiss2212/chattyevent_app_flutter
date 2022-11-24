import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:social_media_app_flutter/infastructure/models/search_groupchat_model.dart';
import 'package:social_media_app_flutter/presentation/screens/chat_page.dart';

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
        final List<SearchGroupchatModel> groupchatList = [];
        for (var groupchat in groupchatListUnconverted) {
          groupchatList.add(SearchGroupchatModel.fromJson(groupchat));
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
