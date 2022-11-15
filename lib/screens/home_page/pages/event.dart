import 'dart:math';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:social_media_app_flutter/models/mini_private_event.dart';

class Event extends StatefulWidget {
  const Event({super.key});

  @override
  State<Event> createState() => _EventState();
}

class _EventState extends State<Event> {
  @override
  Widget build(BuildContext context) {
    return Query(
      options: QueryOptions(document: gql("""
        query {
          findPrivateEvents {
            _id
            title
            coverImageLink
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

        final privateEventListUnconverted = result.data!["findPrivateEvents"];
        final List<MiniPrivateEvent> privateEventList = [];
        for (var miniPrivateEvent in privateEventListUnconverted) {
          privateEventList.add(
            MiniPrivateEvent(
              miniPrivateEvent["_id"],
              miniPrivateEvent["title"],
              miniPrivateEvent["coverImageLink"],
            ),
          );
        }

        return GridView.builder(
          padding: const EdgeInsets.all(8),
          itemBuilder: (context, index) {
            return GridTile(
              child: Container(
                height: 200,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(5),
                  ),
                ),
                child: Text(privateEventList[index].title),
              ),
            );
          },
          itemCount: privateEventList.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: max(
              (MediaQuery.of(context).size.width ~/ 250).toInt(),
              1,
            ),
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
          ),
        );
      },
    );
  }
}
