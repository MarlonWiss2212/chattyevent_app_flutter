import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:social_media_app_flutter/application/bloc/current_groupchat/current_chat_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/user_search/user_search_cubit.dart';
import 'package:social_media_app_flutter/core/filter/user/find_users_filter.dart';
import 'package:social_media_app_flutter/domain/entities/groupchat/groupchat_user_entity.dart';
import 'package:social_media_app_flutter/domain/entities/user/user_entity.dart';
import 'package:social_media_app_flutter/presentation/widgets/general/user_list/selectable_user_grid_list.dart';

/// replace this with selectable user grid list
class AddUserGroupchatListWithSearchbar extends StatelessWidget {
  const AddUserGroupchatListWithSearchbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocBuilder<CurrentChatCubit, CurrentChatState>(
        builder: (context, state) {
          return SelectableUserGridList(
            reloadRequest: ({String? text}) {
              BlocProvider.of<UserSearchCubit>(context).getUsersViaApi(
                findUsersFilter: FindUsersFilter(search: text),
              );
            },
            loadMoreRequest: ({String? text}) {
              BlocProvider.of<UserSearchCubit>(context).getUsersViaApi(
                loadMore: true,
                findUsersFilter: FindUsersFilter(search: text),
              );
            },
            userButton: (user) => PlatformElevatedButton(
              color: Theme.of(context).colorScheme.primaryContainer,
              onPressed: () {
                BlocProvider.of<CurrentChatCubit>(context)
                    .addUserToChat(userId: user.id);
              },
              child: Text(
                "Hinzufügen",
                style: Theme.of(context).textTheme.labelMedium,
              ),
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
