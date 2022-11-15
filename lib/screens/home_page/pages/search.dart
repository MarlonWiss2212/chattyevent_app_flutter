import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:social_media_app_flutter/models/mini_user.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Query(
        options: QueryOptions(document: gql("""
            query {
                findUsers {
                  _id
                  username
                  firstname
                  lastname
                  email
                  birthdate
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

          final userListUnconverted = result.data!["findUsers"];
          final List<MiniUser> userList = [];
          for (var miniUser in userListUnconverted) {
            userList.add(MiniUser(
              miniUser["_id"],
              miniUser["username"],
            ));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(10),
            itemBuilder: (context, index) {
              return ListTile(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
                title: Text(userList[index].username),
                onTap: () {},
              );
            },
            itemCount: userList.length,
          );
        },
      ),
    );
  }
}
