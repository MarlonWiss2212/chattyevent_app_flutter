import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class NewGroupchat extends StatefulWidget {
  const NewGroupchat({super.key});

  @override
  State<NewGroupchat> createState() => _NewGroupchatState();
}

class _NewGroupchatState extends State<NewGroupchat> {
  final titleFieldController = TextEditingController();
  final descriptionFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Neuer Gruppenchat'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: [
          TextField(
            controller: titleFieldController,
            decoration: const InputDecoration(
              hintText: 'Name*',
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: descriptionFieldController,
            decoration: const InputDecoration(
              hintText: 'Beschreibung',
            ),
          ),
          const SizedBox(height: 8),
          Mutation(
            options: MutationOptions(
              document: gql("""
                mutation createGroupchat(\$input: CreateGroupchatInput!) {
                  createGroupchat(createGroupchatInput: \$input) {
                    title
                    users {
                      userId
                    }
                  }
                }
              """),
              onCompleted: (data) {
                print(data);
              },
              onError: (error) {
                print(error);
              },
            ),
            builder: (runMutation, result) {
              return ElevatedButton(
                onPressed: () {
                  runMutation({
                    'input': {
                      'title': titleFieldController.text,
                      'description': descriptionFieldController.text
                    }
                  });
                },
                child: const Text("Speichern"),
              );
            },
          )
        ],
      ),
    );
  }
}
