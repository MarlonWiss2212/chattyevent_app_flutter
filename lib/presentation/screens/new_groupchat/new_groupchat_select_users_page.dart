import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:social_media_app_flutter/application/bloc/chat/add_chat_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/user_search/user_search_cubit.dart';
import 'package:social_media_app_flutter/domain/dto/groupchat/create_groupchat_dto.dart';
import 'package:social_media_app_flutter/domain/dto/groupchat/create_user_groupchat_dto.dart';
import 'package:social_media_app_flutter/presentation/router/router.gr.dart';
import 'package:social_media_app_flutter/presentation/widgets/new_groupchat/SelectableUserGridList.dart';
import 'package:social_media_app_flutter/presentation/widgets/new_groupchat/SelectedUsersList.dart';

class NewGroupchatPageSelectUsersPage extends StatefulWidget {
  final String title;
  final File? profileImage;
  final String? description;
  const NewGroupchatPageSelectUsersPage({
    super.key,
    required this.title,
    this.profileImage,
    this.description,
  });

  @override
  State<NewGroupchatPageSelectUsersPage> createState() =>
      _NewGroupchatPageSelectUsersPageState();
}

class _NewGroupchatPageSelectUsersPageState
    extends State<NewGroupchatPageSelectUsersPage> {
  List<CreateUserGroupchatWithUsernameAndImageLink> groupchatUsers = [];

  void _addUserFromCreateGroupchatUsers(
    CreateUserGroupchatWithUsernameAndImageLink userToCreate,
  ) {
    int foundIndex = _findUserInGroupchatUsers(userToCreate.userId);

    if (foundIndex == -1) {
      setState(() {
        groupchatUsers.add(userToCreate);
      });
    }
  }

  int _findUserInGroupchatUsers(String userId) {
    int userIsSavedIndex = -1;

    groupchatUsers.asMap().forEach((index, createGroupchatUser) {
      if (createGroupchatUser.userId == userId) {
        userIsSavedIndex = index;
      }
    });
    return userIsSavedIndex;
  }

  void _removeUserFromCreateGroupchatUsers(String userId) {
    int userIsSavedIndex = _findUserInGroupchatUsers(userId);

    if (userIsSavedIndex != -1) {
      setState(() {
        groupchatUsers.removeAt(userIsSavedIndex);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<UserSearchCubit>(context).getUsers();

    return PlatformScaffold(
      appBar: PlatformAppBar(
        title: Text('Neuer Gruppenchat: ${widget.title}'),
      ),
      body: Column(
        children: [
          BlocBuilder<AddChatCubit, AddChatState>(builder: (context, state) {
            if (state is AddChatLoading) {
              return const LinearProgressIndicator();
            }
            return Container();
          }),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  if (groupchatUsers.isNotEmpty) ...[
                    SelectedUsersList(
                      groupchatUsers: groupchatUsers,
                      onDeleted: (userId) {
                        _removeUserFromCreateGroupchatUsers(userId);
                      },
                    ),
                    const SizedBox(height: 8),
                  ],
                  SelectableUserGridList(
                    onAdded: (newUser) {
                      _addUserFromCreateGroupchatUsers(newUser);
                    },
                    groupchatUsersWithUsername: groupchatUsers,
                  ),
                  const SizedBox(height: 8),
                  // button to save groupchat
                  BlocListener<AddChatCubit, AddChatState>(
                    listener: (context, state) async {
                      if (state is AddChatLoaded) {
                        AutoRouter.of(context).root.replace(
                              ChatPageWrapperRoute(
                                groupchatId: state.addedChat.id,
                                loadChat: false,
                              ),
                            );
                      }
                    },
                    child: SizedBox(
                      width: double.infinity,
                      child: PlatformElevatedButton(
                        onPressed: () {
                          BlocProvider.of<AddChatCubit>(context).createChat(
                            createGroupchatDto: CreateGroupchatDto(
                              title: widget.title,
                              description: widget.description,
                              users: groupchatUsers,
                              profileImage: widget.profileImage,
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
          ),
        ],
      ),
    );
  }
}
