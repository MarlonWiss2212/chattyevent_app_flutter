import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:social_media_app_flutter/application/bloc/chat/chat_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/user_search/user_search_bloc.dart';
import 'package:social_media_app_flutter/domain/entities/groupchat/groupchat_user_entity.dart';
import 'package:social_media_app_flutter/domain/entities/user_entity.dart';
import 'package:social_media_app_flutter/domain/filter/get_users_filter.dart';
import 'package:social_media_app_flutter/presentation/widgets/user_grid_list.dart';

class AddUserGroupchatListWithSearchbar extends StatelessWidget {
  final List<GroupchatUserEntity> groupchatUsers;
  final String groupchatId;
  const AddUserGroupchatListWithSearchbar({
    super.key,
    required this.groupchatUsers,
    required this.groupchatId,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          PlatformTextField(
            onChanged: (text) {
              BlocProvider.of<UserSearchBloc>(context).add(
                UserSearchGetUsersEvent(
                  getUsersFilterParam: GetUsersFilter(search: text),
                ),
              );
            },
            hintText: "User Suche: ",
          ),
          const SizedBox(height: 8),
          BlocBuilder<UserSearchBloc, UserSearchState>(
            builder: (context, state) {
              if (state is UserSearchStateLoaded) {
                List<UserEntity> filteredUsers = [];

                // checks if user is already in chat if not it should be visible
                for (final user in state.users) {
                  bool pushUser = true;
                  for (final groupchatUser in groupchatUsers) {
                    if (groupchatUser.userId == user.id) {
                      pushUser = false;
                      break;
                    }
                  }
                  if (pushUser) {
                    filteredUsers.add(user);
                  }
                }

                return Expanded(
                  child: UserGridList(
                    users: filteredUsers,
                    button: (user) => PlatformTextButton(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      onPressed: () {
                        BlocProvider.of<ChatCubit>(context).addUserToChat(
                          groupchatId: groupchatId,
                          userIdToAdd: user.id,
                        );
                      },
                      child: Text(
                        "Hinzufügen",
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                    ),
                  ),
                );
              } else if (state is UserSearchStateLoading) {
                return Expanded(
                  child: Center(
                    child: PlatformCircularProgressIndicator(),
                  ),
                );
              } else {
                return Expanded(
                  child: Center(
                    child: PlatformTextButton(
                      child: Text(
                        state is UserSearchStateError
                            ? state.message
                            : "User laden",
                      ),
                      onPressed: () =>
                          BlocProvider.of<UserSearchBloc>(context).add(
                        UserSearchGetUsersEvent(),
                      ),
                    ),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
