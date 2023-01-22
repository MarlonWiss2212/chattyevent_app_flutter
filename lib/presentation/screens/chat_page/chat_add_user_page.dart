import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:social_media_app_flutter/application/bloc/chat/chat_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/chat/current_chat_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/user_search/user_search_cubit.dart';
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
    BlocProvider.of<UserSearchCubit>(context).getUsersViaApi();

    return BlocBuilder<CurrentChatCubit, CurrentChatState>(
      builder: (context, state) {
        GroupchatEntity? foundGroupchat =
            BlocProvider.of<ChatCubit>(context).getGroupchatById(
          groupchatId: groupchatId,
        );

        return PlatformScaffold(
          appBar: PlatformAppBar(
            title: const Text("User zum Chat hinzufügen"),
          ),
          body: state is CurrentChatLoading
              ? Center(child: PlatformCircularProgressIndicator())
              : foundGroupchat != null && state is CurrentChatLoaded
                  ? Column(
                      children: [
                        if (state is CurrentChatEditing) ...{
                          const LinearProgressIndicator()
                        },
                        Expanded(
                          child: AddUserGroupchatListWithSearchbar(
                            groupchatUsers: foundGroupchat.users ?? [],
                            groupchatId: groupchatId,
                          ),
                        ),
                      ],
                    )
                  : Center(
                      child: Text(
                        "Fehler beim Laden des Chats mit der Id $groupchatId",
                        textAlign: TextAlign.center,
                      ),
                    ),
        );
      },
    );
  }
}
