import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app_flutter/application/bloc/chat/chat_bloc.dart';
import 'package:social_media_app_flutter/application/bloc/user/user_bloc.dart';
import 'package:social_media_app_flutter/domain/dto/groupchat/create_groupchat_dto.dart';
import 'package:social_media_app_flutter/domain/dto/groupchat/create_user_groupchat_dto.dart';
import 'package:social_media_app_flutter/domain/entities/user_entity.dart';

class NewGroupchatPage extends StatefulWidget {
  const NewGroupchatPage({super.key});

  @override
  State<NewGroupchatPage> createState() => _NewGroupchatPageState();
}

class _NewGroupchatPageState extends State<NewGroupchatPage> {
  final titleFieldController = TextEditingController();
  final descriptionFieldController = TextEditingController();
  List<CreateUserGroupchatDto> createGroupchatUsers = [];

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
          BlocBuilder<UserBloc, UserState>(
            builder: (context, state) {
              if (state is UserStateLoaded) {
                List<Widget> widgets = [];
                for (final user in state.users) {
                  widgets.add(
                    NewGroupchatUserListItem(
                      user: user,
                      onLongPress: () {
                        int userIsSavedIndex = -1;
                        createGroupchatUsers
                            .asMap()
                            .forEach((index, createGroupchatUser) {
                          if (createGroupchatUser.userId == user.id) {
                            userIsSavedIndex = index;
                          }
                        });
                        if (userIsSavedIndex != -1) {
                          setState(() {
                            createGroupchatUsers.removeAt(userIsSavedIndex);
                          });
                        } else {
                          setState(() {
                            createGroupchatUsers.add(
                              CreateUserGroupchatDto(
                                userId: user.id,
                                admin: false,
                              ),
                            );
                          });
                        }
                      },
                    ),
                  );
                  widgets.add(const SizedBox(width: 8));
                }
                return Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(children: widgets),
                  ),
                );
              } else if (state is UserStateLoading) {
                return const Expanded(child: CircularProgressIndicator());
              }
              return Center(
                child: TextButton(
                  child: Text(
                    state is UserStateError ? state.message : "Daten laden",
                  ),
                  onPressed: () => BlocProvider.of<UserBloc>(context).add(
                    UserRequestEvent(),
                  ),
                ),
              );
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

class NewGroupchatUserListItem extends StatefulWidget {
  final UserEntity user;
  final Function onLongPress;

  NewGroupchatUserListItem({
    super.key,
    required this.user,
    required this.onLongPress,
  });

  @override
  State<NewGroupchatUserListItem> createState() =>
      _NewGroupchatUserListItemState();
}

class _NewGroupchatUserListItemState extends State<NewGroupchatUserListItem> {
  Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: const BorderRadius.all(Radius.circular(8.0)),
      onLongPress: () {
        widget.onLongPress();
        setState(() {
          backgroundColor == null
              ? backgroundColor =
                  Theme.of(context).colorScheme.secondaryContainer
              : backgroundColor = null;
        });
      },
      child: Ink(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(8.0)),
            color: backgroundColor,
          ),
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(100000000000000),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(widget.user.username ?? "Kein Name")
            ],
          ),
        ),
      ),
    );
  }
}
