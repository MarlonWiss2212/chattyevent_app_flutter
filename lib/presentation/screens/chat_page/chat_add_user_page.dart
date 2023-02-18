import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:social_media_app_flutter/application/bloc/chat/current_chat_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/user/user_search_cubit.dart';
import 'package:social_media_app_flutter/presentation/widgets/screens/chat_page/chat_add_user_page/add_user_groupchat_list_with_searchbar.dart';

class ChatAddUserPage extends StatelessWidget {
  final String groupchatId;
  const ChatAddUserPage({
    @PathParam('id') required this.groupchatId,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<UserSearchCubit>(context).getUsersViaApi();

    return PlatformScaffold(
      appBar: PlatformAppBar(
        title: const Text("User zum Chat hinzufügen"),
      ),
      body: Column(
        children: [
          BlocBuilder<CurrentChatCubit, CurrentChatState>(
            builder: (context, state) {
              if (state.loadingChat) {
                return const LinearProgressIndicator();
              }
              return const SizedBox();
            },
          ),
          Expanded(
            child: AddUserGroupchatListWithSearchbar(
              groupchatId: groupchatId,
            ),
          ),
        ],
      ),
    );
  }
}
