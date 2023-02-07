import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:social_media_app_flutter/application/bloc/user/user_search_cubit.dart';
import 'package:social_media_app_flutter/domain/dto/groupchat/create_user_groupchat_dto.dart';
import 'package:social_media_app_flutter/domain/entities/user_entity.dart';
import 'package:social_media_app_flutter/domain/filter/get_users_filter.dart';
import 'package:social_media_app_flutter/presentation/widgets/user_grid_list.dart';

class SelectableUserGridList extends StatelessWidget {
  final void Function(
    CreateUserGroupchatWithUsernameAndImageLink newUser,
  ) onAdded;
  final List<CreateUserGroupchatWithUsernameAndImageLink> groupchatUsers;

  const SelectableUserGridList({
    super.key,
    required this.onAdded,
    required this.groupchatUsers,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
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
          BlocBuilder<UserSearchCubit, UserSearchState>(
            builder: (context, state) {
              if (state is UserSearchStateLoaded) {
                List<UserEntity> filteredUsers = [];

                // checks if user is already selected if not it should be visible
                for (final user in state.users) {
                  int foundIndex = -1;
                  groupchatUsers.asMap().forEach(
                    (index, createGroupchatUser) {
                      if (createGroupchatUser.userId == user.id) {
                        foundIndex = index;
                      }
                    },
                  );

                  if (foundIndex == -1) {
                    filteredUsers.add(user);
                  }
                }

                return Expanded(
                  child: UserGridList(
                    users: filteredUsers,
                    onPress: (user) {
                      onAdded(
                        CreateUserGroupchatWithUsernameAndImageLink(
                          userId: user.id,
                          username: user.username ?? "Kein Username",
                          imageLink: user.profileImageLink,
                        ),
                      );
                    },
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
                      onPressed: () => BlocProvider.of<UserSearchCubit>(context)
                          .getUsersViaApi(),
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
