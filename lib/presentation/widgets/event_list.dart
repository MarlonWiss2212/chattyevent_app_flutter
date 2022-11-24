import 'dart:math';

import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:social_media_app_flutter/infastructure/models/search_private_event_model.dart';

class EventList extends StatefulWidget {
  const EventList({super.key});

  @override
  State<EventList> createState() => _EventListState();
}

class _EventListState extends State<EventList> {
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
        final List<SearchPrivateEventModel> privateEventList = [];
        for (var miniPrivateEvent in privateEventListUnconverted) {
          privateEventList.add(
            SearchPrivateEventModel.fromJson(miniPrivateEvent),
          );
        }

        return GridView.builder(
          padding: const EdgeInsets.all(8),
          itemBuilder: (context, index) {
            return Card(
              elevation: 0,
              color: Theme.of(context).colorScheme.surfaceVariant,
              child: Container(
                padding: const EdgeInsets.all(8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      privateEventList[index].title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          itemCount: privateEventList.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: max(
              (MediaQuery.of(context).size.width ~/ 225).toInt(),
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
