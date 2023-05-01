import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:social_media_app_flutter/application/bloc/user_search/user_search_cubit.dart';
import 'package:social_media_app_flutter/core/filter/user/find_users_filter.dart';
import 'package:social_media_app_flutter/domain/entities/user/user_entity.dart';
import 'package:social_media_app_flutter/presentation/widgets/general/user_list/user_grid_list.dart';

class SelectableUserGridList extends StatelessWidget {
  final void Function(UserEntity user)? onUserPress;
  final List<UserEntity> Function(List<UserEntity> users)? filterUsers;
  const SelectableUserGridList({
    super.key,
    this.onUserPress,
    this.filterUsers,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          PlatformTextFormField(
            onChanged: (text) {
              BlocProvider.of<UserSearchCubit>(context).getUsersViaApi(
                findUsersFilter: FindUsersFilter(search: text),
              );
            },
            hintText: "User Suche: ",
          ),
          const SizedBox(height: 8),
          BlocBuilder<UserSearchCubit, UserSearchState>(
            builder: (context, state) {
              if (state.status == UserSearchStateStatus.loading) {
                return Expanded(
                  child: Center(
                    child: PlatformCircularProgressIndicator(),
                  ),
                );
              }

              final filteredUsers =
                  filterUsers != null ? filterUsers!(state.users) : state.users;

              return Expanded(
                child: UserGridList(
                  users: filteredUsers,
                  onPress: onUserPress,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
