import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:social_media_app_flutter/presentation/router/router.gr.dart';
import 'package:social_media_app_flutter/presentation/widgets/dialog/buttons/ok_button.dart';
import 'package:social_media_app_flutter/presentation/widgets/circle_image/select_circle_image.dart';

class NewGroupchatPage extends StatefulWidget {
  const NewGroupchatPage({super.key});

  @override
  State<NewGroupchatPage> createState() => _NewGroupchatPageState();
}

class _NewGroupchatPageState extends State<NewGroupchatPage> {
  File? image;
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
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    SelectCircleImage(
                      imageChanged: (newImage) {
                        setState(() {
                          image = newImage;
                        });
                      },
                      image: image,
                    ),
                    const SizedBox(height: 20),
                    PlatformTextFormField(
                      controller: titleFieldController,
                      hintText: 'Name*',
                    ),
                    const SizedBox(height: 8),
                    PlatformTextFormField(
                      controller: descriptionFieldController,
                      hintText: 'Beschreibung',
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8.0),
            SizedBox(
              width: double.infinity,
              child: PlatformElevatedButton(
                onPressed: () async {
                  if (titleFieldController.text.isEmpty) {
                    return await showPlatformDialog(
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
                      profileImage: image,
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
