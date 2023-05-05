import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chattyevent_app_flutter/application/bloc/add_groupchat/add_groupchat_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/user_search/user_search_cubit.dart';
import 'package:chattyevent_app_flutter/core/dto/groupchat/groupchat_user/create_groupchat_user_from_create_groupchat_dto.dart';
import 'package:chattyevent_app_flutter/domain/entities/user/user_entity.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/user_list/selectable_user_grid_list.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/user_list/selected_user_list.dart';

class NewGroupchatSelectUserTab extends StatelessWidget {
  const NewGroupchatSelectUserTab({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<UserSearchCubit>(context).getUsersByPermissionViaApi(
      followedToGroupchatPermission: "ADD",
    );

    return Padding(
      padding: const EdgeInsets.all(8),
      child: BlocBuilder<AddGroupchatCubit, AddGroupchatState>(
        buildWhen: (p, c) => p.groupchatUsers.length != c.groupchatUsers.length,
        builder: (context, state) {
          return Column(
            children: [
              SelectedUsersList(
                users: state.groupchatUsers.map((e) => e.user).toList(),
                onPress: (user) => BlocProvider.of<AddGroupchatCubit>(context)
                    .removeGroupchatUserUserFromList(
                  userId: user.id,
                ),
              ),
              Expanded(
                child: SelectableUserGridList(
                  //TODO: in future over api
                  filterUsers: (users) {
                    List<UserEntity> filteredUsers = [];

                    for (final user in users) {
                      int foundIndex = state.groupchatUsers.indexWhere(
                        (groupchatUser) => groupchatUser.user.id == user.id,
                      );
                      if (foundIndex == -1) {
                        filteredUsers.add(user);
                      }
                    }
                    return filteredUsers;
                  },
                  reloadRequest: ({String? text}) {
                    BlocProvider.of<UserSearchCubit>(context)
                        .getUsersByPermissionViaApi(
                      followedToGroupchatPermission: "ADD",
                    );
                  },
                  loadMoreRequest: ({String? text}) {
                    BlocProvider.of<UserSearchCubit>(context)
                        .getUsersByPermissionViaApi(
                      loadMore: true,
                      followedToGroupchatPermission: "ADD",
                    );
                  },
                  showTextSearch: false,
                  onUserPress: (user) {
                    BlocProvider.of<AddGroupchatCubit>(context)
                        .addGroupchatUserToList(
                      groupchatUser:
                          CreateGroupchatUserFromCreateGroupchatDtoWithUserEntity(
                        user: user,
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
