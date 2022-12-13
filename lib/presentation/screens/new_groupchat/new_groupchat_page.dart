import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app_flutter/application/bloc/chat/chat_bloc.dart';
import 'package:social_media_app_flutter/application/bloc/user_search/user_search_bloc.dart';
import 'package:social_media_app_flutter/domain/dto/groupchat/create_groupchat_dto.dart';
import 'package:social_media_app_flutter/domain/dto/groupchat/create_user_groupchat_dto.dart';
import 'package:social_media_app_flutter/domain/entities/user_entity.dart';
import 'package:social_media_app_flutter/presentation/router/router.gr.dart';
import 'package:social_media_app_flutter/presentation/screens/new_groupchat/new_groupchat_select_users_page.dart';
import 'package:social_media_app_flutter/presentation/widgets/user_list_item.dart';

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
                        return AlertDialog(
                          title: const Text("Fehler"),
                          content: const Text(
                              "Sie müssen erst einen Namen vergeben"),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: const Text("OK"),
                            )
                          ],
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
