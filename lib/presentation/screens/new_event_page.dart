import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class NewPrivateEventPage extends StatefulWidget {
  const NewPrivateEventPage({super.key});

  @override
  State<NewPrivateEventPage> createState() => _NewPrivateEventPageState();
}

class _NewPrivateEventPageState extends State<NewPrivateEventPage> {
  DateTime date = DateTime.now();
  final titleFieldController = TextEditingController();
  final groupchatFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Neues Event'),
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
          ElevatedButton(
            child: Text("Datum wählen: $date"),
            onPressed: () async {
              DateTime currentDate = DateTime.now();
              DateTime? newDate = await showDatePicker(
                context: context,
                initialDate: date,
                firstDate: currentDate,
                lastDate: DateTime(currentDate.year + 10),
              );

              if (newDate == null) return;
              setState(() {
                date = newDate;
              });
            },
          ),
          TextField(
            controller: groupchatFieldController,
            decoration: const InputDecoration(
              hintText: 'Chat*',
            ),
          ),
          const SizedBox(height: 8),
          Mutation(
            options: MutationOptions(
              document: gql("""
                mutation createPrivateEvent(\$input: CreatePrivateEventInput!) {
                  createPrivateEvent(createPrivateEventInput: \$input) {
                    _id
                  }
                }
              """),
              onCompleted: (data) {
                if (data != null) {
                  Navigator.pop(context);
                }
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
                      'eventDate': date.toIso8601String(),
                      'connectedGroupchat': groupchatFieldController.text
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
