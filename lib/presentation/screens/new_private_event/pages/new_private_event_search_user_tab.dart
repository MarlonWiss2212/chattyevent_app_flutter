import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app_flutter/application/bloc/add_private_event/add_private_event_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/user_search/user_search_cubit.dart';
import 'package:social_media_app_flutter/core/dto/private_event/private_event_user/create_private_event_user_from_private_event_dto.dart';
import 'package:social_media_app_flutter/domain/entities/user/user_entity.dart';
import 'package:social_media_app_flutter/presentation/widgets/general/user_list/selectable_user_grid_list.dart';
import 'package:social_media_app_flutter/presentation/widgets/general/user_list/selected_user_list.dart';

class NewPrivateEventSearchUserTab extends StatelessWidget {
  const NewPrivateEventSearchUserTab({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<UserSearchCubit>(context).getUsersByPermissionViaApi(
      followedToPrivateEventPermission: "ADD",
    );

    return Padding(
      padding: const EdgeInsets.all(8),
      child: BlocBuilder<AddPrivateEventCubit, AddPrivateEventState>(
        buildWhen: (p, c) =>
            p.privateEventUsersDto.length != c.privateEventUsersDto.length,
        builder: (context, state) {
          return Column(
            children: [
              SelectedUsersList(
                users: state.privateEventUsersDto.map((e) => e.user).toList(),
                onPress: (user) =>
                    BlocProvider.of<AddPrivateEventCubit>(context)
                        .removePrivateEventUserFromList(
                  userId: user.id,
                ),
              ),
              SelectableUserGridList(
                filterUsers: (users) {
                  List<UserEntity> filteredUsers = [];

                  for (final user in users) {
                    int foundIndex = state.privateEventUsersDto.indexWhere(
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
                    followedToPrivateEventPermission: "ADD",
                  );
                },
                loadMoreRequest: ({String? text}) {
                  BlocProvider.of<UserSearchCubit>(context)
                      .getUsersByPermissionViaApi(
                    loadMore: true,
                    followedToPrivateEventPermission: "ADD",
                  );
                },
                showTextSearch: false,
                onUserPress: (user) {
                  BlocProvider.of<AddPrivateEventCubit>(context)
                      .addPrivateEventUserToList(
                    privateEventUserDto:
                        CreatePrivateEventUserFromPrivateEventDtoWithUserEntity(
                      user: user,
                    ),
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
