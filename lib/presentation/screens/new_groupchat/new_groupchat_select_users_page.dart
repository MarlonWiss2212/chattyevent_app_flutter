import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app_flutter/application/bloc/auth/auth_bloc.dart';
import 'package:social_media_app_flutter/application/bloc/chat/chat_bloc.dart';
import 'package:social_media_app_flutter/application/bloc/user_search/user_search_bloc.dart';
import 'package:social_media_app_flutter/domain/dto/groupchat/create_groupchat_dto.dart';
import 'package:social_media_app_flutter/domain/dto/groupchat/create_user_groupchat_dto.dart';
import 'package:social_media_app_flutter/presentation/widgets/user_list_item.dart';

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
        title: const Text('Neuer Gruppenchat'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            if (groupchatUsersWithUsername.isNotEmpty) ...[
              SizedBox(
                width: double.infinity,
                height: 60,
                child: Row(
                  children: [
                    Expanded(
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Chip(
                            label: Text(
                                groupchatUsersWithUsername[index].username),
                            onDeleted: () {
                              _removeUserFromCreateGroupchatUsers(
                                groupchatUsersWithUsername[index].userId,
                              );
                            },
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox(width: 8);
                        },
                        itemCount: groupchatUsersWithUsername.length,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(groupchatUsersWithUsername.length.toString())
                  ],
                ),
              )
            ],
            const SizedBox(height: 8),
            Expanded(
              child: BlocBuilder<UserSearchBloc, UserSearchState>(
                builder: (context, state) {
                  if (state is UserSearchStateLoaded) {
                    final filteredUsers = [];

                    for (final user in state.users) {
                      int foundIndex =
                          _findUserInGroupchatUsersWithUsername(user.id);
                      if (foundIndex == -1) {
                        filteredUsers.add(user);
                      }
                    }

                    return GridView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return UserListItem(
                          user: filteredUsers[index],
                          onLongPress: () {
                            _addUserFromCreateGroupchatUsers(
                              CreateUserGroupchatWithUsername(
                                userId: filteredUsers[index].id,
                                username: filteredUsers[index].username ??
                                    "Kein Username",
                              ),
                            );
                          },
                        );
                      },
                      itemCount: filteredUsers.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: max(
                          (MediaQuery.of(context).size.width ~/ 150).toInt(),
                          1,
                        ),
                        mainAxisSpacing: 8,
                        crossAxisSpacing: 8,
                      ),
                    );
                  } else if (state is UserSearchStateLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    return Center(
                      child: TextButton(
                        child: Text(
                          state is UserSearchStateError
                              ? state.message
                              : "User laden",
                        ),
                        onPressed: () =>
                            BlocProvider.of<UserSearchBloc>(context).add(
                          SearchUsersEvent(),
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
            const SizedBox(height: 8),
            BlocListener<ChatBloc, ChatState>(
              listener: (context, state) {
                // AutoRouter.of(context).pop();
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
