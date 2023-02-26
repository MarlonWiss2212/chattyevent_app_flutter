import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:social_media_app_flutter/application/bloc/chat/current_chat_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/user/user_search_cubit.dart';
import 'package:social_media_app_flutter/domain/entities/user_entity.dart';
import 'package:social_media_app_flutter/core/filter/get_users_filter.dart';
import 'package:social_media_app_flutter/presentation/widgets/user_list/user_grid_list.dart';

class AddUserGroupchatListWithSearchbar extends StatelessWidget {
  final String groupchatId;
  const AddUserGroupchatListWithSearchbar({
    super.key,
    required this.groupchatId,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          PlatformTextFormField(
            onChanged: (text) {
              BlocProvider.of<UserSearchCubit>(context).getUsersViaApi(
                getUsersFilter: GetUsersFilter(search: text),
              );
            },
            hintText: "User Suche: ",
          ),
          const SizedBox(height: 8),
          BlocBuilder<CurrentChatCubit, CurrentChatState>(
            buildWhen: (previous, current) =>
                previous.currentChat.users != current.currentChat.users,
            builder: (context, currentChatState) {
              return BlocBuilder<UserSearchCubit, UserSearchState>(
                builder: (context, state) {
                  if (state is UserSearchStateLoaded) {
                    List<UserEntity> filteredUsers = [];

                    // checks if user is already in chat if not it should be visible
                    for (final user in state.users) {
                      bool pushUser = true;
                      for (final groupchatUser
                          in currentChatState.currentChat.users ?? []) {
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
                        button: (user) => PlatformElevatedButton(
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
                              BlocProvider.of<UserSearchCubit>(context)
                                  .getUsersViaApi(),
                        ),
                      ),
                    );
                  }
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
