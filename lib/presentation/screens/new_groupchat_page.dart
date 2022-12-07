import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app_flutter/application/bloc/chat/chat_bloc.dart';
import 'package:social_media_app_flutter/application/bloc/user_search/user_search_bloc.dart';
import 'package:social_media_app_flutter/domain/dto/groupchat/create_groupchat_dto.dart';
import 'package:social_media_app_flutter/domain/dto/groupchat/create_user_groupchat_dto.dart';
import 'package:social_media_app_flutter/domain/entities/user_entity.dart';
import 'package:social_media_app_flutter/presentation/widgets/user_list_item.dart';

class NewGroupchatPage extends StatefulWidget {
  const NewGroupchatPage({super.key});

  @override
  State<NewGroupchatPage> createState() => _NewGroupchatPageState();
}

class _NewGroupchatPageState extends State<NewGroupchatPage> {
  final titleFieldController = TextEditingController();
  final descriptionFieldController = TextEditingController();
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
          BlocBuilder<UserSearchBloc, UserSearchState>(
            builder: (context, state) {
              if (state is UserSearchStateLoaded) {
                List<Widget> widgets = [];
                for (final user in state.users) {
                  widgets.add(
                    UserListItem(
                      user: user,
                      onLongPress: () {
                        _toggleUserFromCreateGroupchatUsers(user);
                      },
                    ),
                  );
                  widgets.add(const SizedBox(width: 8));
                }
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(children: widgets),
                );
              } else if (state is UserSearchStateLoading) {
                return const Expanded(child: CircularProgressIndicator());
              } else {
                return Center(
                  child: TextButton(
                    child: Text(
                      state is UserSearchStateError
                          ? state.message
                          : "Daten laden",
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
          const SizedBox(height: 8),
          BlocListener<ChatBloc, ChatState>(
            listener: (context, state) {
              AutoRouter.of(context).pop();
            },
            child: ElevatedButton(
              onPressed: () {
                BlocProvider.of<ChatBloc>(context).add(
                  ChatCreateEvent(
                    createGroupchatDto: CreateGroupchatDto(
                      title: titleFieldController.text,
                      description: descriptionFieldController.text,
                      users: createGroupchatUsers,
                    ),
                  ),
                );
              },
              child: const Text("Speichern"),
            ),
          ),
        ],
      ),
    );
  }
}
