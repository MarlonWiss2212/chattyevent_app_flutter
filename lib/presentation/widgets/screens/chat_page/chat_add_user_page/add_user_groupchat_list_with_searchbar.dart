import 'package:chattyevent_app_flutter/presentation/widgets/general/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chattyevent_app_flutter/application/bloc/current_groupchat/current_chat_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/user_search/user_search_cubit.dart';
import 'package:chattyevent_app_flutter/domain/entities/groupchat/groupchat_user_entity.dart';
import 'package:chattyevent_app_flutter/domain/entities/user/user_entity.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/user_list/selectable_user_grid_list.dart';

class AddUserGroupchatListWithSearchbar extends StatelessWidget {
  const AddUserGroupchatListWithSearchbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocBuilder<CurrentChatCubit, CurrentChatState>(
        builder: (context, state) {
          return SelectableUserGridList(
            showTextSearch: false,
            reloadRequest: ({String? text}) {
              BlocProvider.of<UserSearchCubit>(context)
                  .getUsersByPermissionViaApi(
                requesterGroupchatAddPermission: "ADD",
              );
            },
            loadMoreRequest: ({String? text}) {
              BlocProvider.of<UserSearchCubit>(context)
                  .getUsersByPermissionViaApi(
                loadMore: true,
                requesterGroupchatAddPermission: "ADD",
              );
            },
            userButton: (user) => Button(
              color: Theme.of(context).colorScheme.primaryContainer,
              onTap: () {
                BlocProvider.of<CurrentChatCubit>(context)
                    .addUserToChat(userId: user.id);
              },
              text: "Hinzufügen",
            ),
            filterUsers: (users) {
              List<UserEntity> filteredUsers = [];

              // checks if user is already in chat if not it should be visible
              for (final user in users) {
                bool pushUser = true;
                for (GroupchatUserEntity groupchatUser in state.users) {
                  if (groupchatUser.id == user.id) {
                    pushUser = false;
                    break;
                  }
                }
                if (pushUser) {
                  filteredUsers.add(user);
                }
              }
              return filteredUsers;
            },
          );
        },
      ),
    );
  }
}
