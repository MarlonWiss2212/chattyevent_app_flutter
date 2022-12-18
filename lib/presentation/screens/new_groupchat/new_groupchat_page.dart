import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
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
    return PlatformScaffold(
      appBar: PlatformAppBar(
        leading: const AutoLeadingButton(),
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
                  PlatformTextField(
                    controller: titleFieldController,
                    hintText: 'Name*',
                  ),
                  const SizedBox(height: 8),
                  PlatformTextField(
                    controller: descriptionFieldController,
                    hintText: 'Beschreibung',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8.0),
            SizedBox(
              width: double.infinity,
              child: PlatformElevatedButton(
                onPressed: () async {
                  if (titleFieldController.text.isEmpty) {
                    return await showDialog(
                      context: context,
                      builder: (context) {
                        return PlatformAlertDialog(
                          title: const Text("Fehler"),
                          content: const Text(
                            "Sie müssen erst einen Namen vergeben",
                          ),
                          actions: const [OKButton()],
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
