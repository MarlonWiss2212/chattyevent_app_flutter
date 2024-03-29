import 'package:auto_route/annotations.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chattyevent_app_flutter/application/bloc/current_groupchat/current_chat_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/user_search/user_search_cubit.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/screens/chat_page/chat_add_user_page/add_user_groupchat_list_with_searchbar.dart';

@RoutePage()
class GroupchatAddUserPage extends StatefulWidget {
  final String groupchatId;
  const GroupchatAddUserPage({
    @PathParam('id') required this.groupchatId,
    super.key,
  });

  @override
  State<GroupchatAddUserPage> createState() => _GroupchatAddUserPageState();
}

class _GroupchatAddUserPageState extends State<GroupchatAddUserPage> {
  @override
  void initState() {
    BlocProvider.of<UserSearchCubit>(context).getFollowedViaApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("groupchatPage.addUserPage.title").tr(),
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
