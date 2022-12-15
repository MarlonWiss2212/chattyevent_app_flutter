import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app_flutter/application/bloc/auth/auth_bloc.dart';
import 'package:social_media_app_flutter/application/bloc/chat/chat_bloc.dart';
import 'package:social_media_app_flutter/domain/dto/groupchat/create_groupchat_dto.dart';
import 'package:social_media_app_flutter/domain/dto/groupchat/create_user_groupchat_dto.dart';
import 'package:social_media_app_flutter/presentation/router/router.gr.dart';
import 'package:social_media_app_flutter/presentation/widgets/new_groupchat/SelectableUserGridList.dart';
import 'package:social_media_app_flutter/presentation/widgets/new_groupchat/SelectedUsersChipList.dart';

class NewGroupchatPageSelectUsersPage extends StatefulWidget {
  final String title;
  final String? description;
  const NewGroupchatPageSelectUsersPage({
    super.key,
    required this.title,
    this.description,
  });

  @override
  State<NewGroupchatPageSelectUsersPage> createState() =>
      _NewGroupchatPageSelectUsersPageState();
}

class _NewGroupchatPageSelectUsersPageState
    extends State<NewGroupchatPageSelectUsersPage> {
  List<CreateUserGroupchatWithUsername> groupchatUsersWithUsername = [];

  void _addUserFromCreateGroupchatUsers(
      CreateUserGroupchatWithUsername userToCreate) {
    int foundIndex = _findUserInGroupchatUsersWithUsername(userToCreate.userId);

    if (foundIndex == -1) {
      setState(() {
        groupchatUsersWithUsername.add(userToCreate);
      });
    }
  }

  int _findUserInGroupchatUsersWithUsername(String userId) {
    int userIsSavedIndex = -1;

    groupchatUsersWithUsername.asMap().forEach((index, createGroupchatUser) {
      if (createGroupchatUser.userId == userId) {
        userIsSavedIndex = index;
      }
    });
    return userIsSavedIndex;
  }

  void _removeUserFromCreateGroupchatUsers(String userId) {
    int userIsSavedIndex = _findUserInGroupchatUsersWithUsername(userId);

    if (userIsSavedIndex != -1) {
      setState(() {
        groupchatUsersWithUsername.removeAt(userIsSavedIndex);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Neuer Gruppenchat: ${widget.title}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            if (groupchatUsersWithUsername.isNotEmpty) ...[
              SelectedUsersChipList(
                groupchatUsersWithUsername: groupchatUsersWithUsername,
                onDeleted: (userId) {
                  _removeUserFromCreateGroupchatUsers(userId);
                },
              )
            ],
            const SizedBox(height: 8),
            SelectableUserGridList(
              onAdded: (newUser) {
                _addUserFromCreateGroupchatUsers(newUser);
              },
              groupchatUsersWithUsername: groupchatUsersWithUsername,
            ),
            const SizedBox(height: 8),
            // button to save groupchat
            BlocListener<ChatBloc, ChatState>(
              listener: (context, state) {
                if (state is ChatStateLoaded) {
                  for (final chat in state.chats) {
                    if (chat.title == widget.title) {
                      AutoRouter.of(context).popUntilRoot();
                      AutoRouter.of(context).push(
                        ChatPageRoute(groupchat: chat),
                      );
                    }
                  }
                }
              },
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    BlocProvider.of<ChatBloc>(context).add(
                      ChatCreateEvent(
                        createGroupchatDto: CreateGroupchatDto(
                          title: widget.title,
                          description: widget.description,
                          users: groupchatUsersWithUsername,
                        ),
                      ),
                    );
                  },
                  child: const Text("Speichern"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
