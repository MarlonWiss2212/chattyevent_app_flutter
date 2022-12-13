import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app_flutter/application/bloc/chat/chat_bloc.dart';
import 'package:social_media_app_flutter/application/bloc/user_search/user_search_bloc.dart';
import 'package:social_media_app_flutter/domain/dto/groupchat/create_groupchat_dto.dart';
import 'package:social_media_app_flutter/domain/dto/groupchat/create_user_groupchat_dto.dart';
import 'package:social_media_app_flutter/domain/entities/user_entity.dart';
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
  List<CreateUserGroupchatDto> createGroupchatUsers = [];

  void _toggleUserFromCreateGroupchatUsers(UserEntity user) {
    int userIsSavedIndex = -1;

    createGroupchatUsers.asMap().forEach((index, createGroupchatUser) {
      if (createGroupchatUser.userId == user.id) {
        userIsSavedIndex = index;
      }
    });

    if (userIsSavedIndex != -1) {
      createGroupchatUsers.removeAt(userIsSavedIndex);
    } else {
      createGroupchatUsers.add(
        CreateUserGroupchatDto(
          userId: user.id,
          admin: false,
        ),
      );
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
            Expanded(
              child: BlocBuilder<UserSearchBloc, UserSearchState>(
                bloc: BlocProvider.of<UserSearchBloc>(context)
                  ..add(SearchUsersEvent()),
                builder: (context, state) {
                  if (state is UserSearchStateLoaded) {
                    return GridView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return UserListItem(
                          user: state.users[index],
                          onPress: () {},
                        );
                      },
                      itemCount: state.users.length,
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
                          users: createGroupchatUsers,
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
