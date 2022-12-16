import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:social_media_app_flutter/application/bloc/user_search/user_search_bloc.dart';
import 'package:social_media_app_flutter/domain/dto/groupchat/create_user_groupchat_dto.dart';
import 'package:social_media_app_flutter/domain/entities/user_entity.dart';
import 'package:social_media_app_flutter/presentation/widgets/user_grid_list.dart';

class SelectableUserGridList extends StatelessWidget {
  final void Function(CreateUserGroupchatWithUsername newUser) onAdded;
  final List<CreateUserGroupchatWithUsername> groupchatUsersWithUsername;

  const SelectableUserGridList({
    super.key,
    required this.onAdded,
    required this.groupchatUsersWithUsername,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<UserSearchBloc, UserSearchState>(
        builder: (context, state) {
          if (state is UserSearchStateLoaded) {
            List<UserEntity> filteredUsers = [];

            // checks if user is already selected if not it should be visible
            for (final user in state.users) {
              int foundIndex = -1;
              groupchatUsersWithUsername
                  .asMap()
                  .forEach((index, createGroupchatUser) {
                if (createGroupchatUser.userId == user.id) {
                  foundIndex = index;
                }
              });

              if (foundIndex == -1) {
                filteredUsers.add(user);
              }
            }

            return UserGridList(
              users: filteredUsers,
              onPress: (user) {
                onAdded(
                  CreateUserGroupchatWithUsername(
                    userId: user.id,
                    username: user.username ?? "Kein Username",
                  ),
                );
              },
            );
          } else if (state is UserSearchStateLoading) {
            return Center(child: PlatformCircularProgressIndicator());
          } else {
            return Center(
              child: PlatformTextButton(
                child: Text(
                  state is UserSearchStateError ? state.message : "User laden",
                ),
                onPressed: () => BlocProvider.of<UserSearchBloc>(context).add(
                  UserSearchGetUsersEvent(),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
