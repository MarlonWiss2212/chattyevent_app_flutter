import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:social_media_app_flutter/application/bloc/chat/chat_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/user_search/user_search_bloc.dart';
import 'package:social_media_app_flutter/domain/entities/groupchat/groupchat_entity.dart';
import 'package:social_media_app_flutter/presentation/widgets/chat_page/chat_add_user_page/add_user_groupchat_list_with_searchbar.dart';

class ChatAddUserPage extends StatelessWidget {
  final String groupchatId;
  const ChatAddUserPage({
    @PathParam('id') required this.groupchatId,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<UserSearchBloc>(context).add(
      UserSearchGetUsersEvent(),
    );

    return BlocBuilder<ChatCubit, ChatState>(
      builder: (context, state) {
        GroupchatEntity? foundGroupchat;
        if (state is ChatStateLoaded) {
          for (final chat in state.chats) {
            if (chat.id == groupchatId) {
              foundGroupchat = chat;
              break;
            }
          }
        }

        Widget body;

        if (foundGroupchat == null) {
          body = Expanded(
            child: Center(
              child: Text(
                "Fehler beim Laden des Chats mit der Id $groupchatId",
              ),
            ),
          );
        } else {
          body = AddUserGroupchatListWithSearchbar(
            groupchatUsers: foundGroupchat.users,
            groupchatId: groupchatId,
          );
        }

        return PlatformScaffold(
          appBar: PlatformAppBar(
            title: const Text("User zum Chat hinzufügen"),
          ),
          body: body,
        );
      },
    );
  }
}
