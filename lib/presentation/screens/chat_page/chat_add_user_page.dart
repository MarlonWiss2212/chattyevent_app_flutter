import 'package:auto_route/annotations.dart';
import 'package:chattyevent_app_flutter/core/enums/user_relation/requester_groupchat_add_permission_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chattyevent_app_flutter/application/bloc/current_groupchat/current_chat_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/user_search/user_search_cubit.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/screens/chat_page/chat_add_user_page/add_user_groupchat_list_with_searchbar.dart';

class ChatAddUserPage extends StatefulWidget {
  final String groupchatId;
  const ChatAddUserPage({
    @PathParam('id') required this.groupchatId,
    super.key,
  });

  @override
  State<ChatAddUserPage> createState() => _ChatAddUserPageState();
}

class _ChatAddUserPageState extends State<ChatAddUserPage> {
  @override
  void initState() {
    BlocProvider.of<UserSearchCubit>(context).getUsersByPermissionViaApi(
      requesterGroupchatAddPermission: RequesterGroupchatAddPermissionEnum.add,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("User zum Chat hinzufügen"),
      ),
      body: Column(
        children: [
          BlocBuilder<CurrentGroupchatCubit, CurrentGroupchatState>(
            buildWhen: (previous, current) =>
                previous.loadingChat != current.loadingChat,
            builder: (context, state) {
              if (state.loadingChat) {
                return const LinearProgressIndicator();
              }
              return const SizedBox();
            },
          ),
          const Expanded(child: AddUserGroupchatListWithSearchbar()),
        ],
      ),
    );
  }
}
