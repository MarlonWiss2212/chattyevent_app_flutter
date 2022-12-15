import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app_flutter/presentation/router/router.gr.dart';
import 'package:social_media_app_flutter/presentation/widgets/dialog/ok_button.dart';

class NewGroupchatPage extends StatefulWidget {
  const NewGroupchatPage({super.key});

  @override
  State<NewGroupchatPage> createState() => _NewGroupchatPageState();
}

class _NewGroupchatPageState extends State<NewGroupchatPage> {
  final titleFieldController = TextEditingController();
  final descriptionFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Neuer Gruppenchat'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  const SizedBox(height: 8.0),
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
                ],
              ),
            ),
            const SizedBox(height: 8.0),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  if (titleFieldController.text.isEmpty) {
                    return await showDialog(
                      context: context,
                      builder: (context) {
                        return const AlertDialog(
                          title: Text("Fehler"),
                          content: Text("Sie müssen erst einen Namen vergeben"),
                          actions: [OKButton()],
                        );
                      },
                    );
                  }
                  AutoRouter.of(context).push(
                    NewGroupchatPageSelectUsersPageRoute(
                      title: titleFieldController.text,
                      description: descriptionFieldController.text,
                    ),
                  );
                },
                child: const Text("Weiter"),
              ),
            ),
            const SizedBox(height: 8.0),
          ],
        ),
      ),
    );
  }
}
