import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:social_media_app_flutter/application/bloc/chat/add_groupchat_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/user/user_search_cubit.dart';
import 'package:social_media_app_flutter/core/dto/groupchat/create_groupchat_user_from_create_groupchat_dto.dart';
import 'package:social_media_app_flutter/domain/entities/user_entity.dart';
import 'package:social_media_app_flutter/core/filter/get_users_filter.dart';
import 'package:social_media_app_flutter/presentation/widgets/user_list/user_grid_list.dart';

class SelectableUserGridList extends StatelessWidget {
  const SelectableUserGridList({super.key});

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
          BlocBuilder<AddGroupchatCubit, AddGroupchatState>(
            builder: (context, addGroupchatState) {
              return BlocBuilder<UserSearchCubit, UserSearchState>(
                builder: (context, state) {
                  if (state is UserSearchStateLoaded) {
                    List<UserEntity> filteredUsers = [];

                    for (final user in state.users) {
                      if (addGroupchatState.groupchatUsers == null) {
                        filteredUsers = state.users;
                        break;
                      }
                      int foundIndex =
                          addGroupchatState.groupchatUsers!.indexWhere(
                        (groupchatUser) => groupchatUser.authId == user.authId,
                      );
                      if (foundIndex == -1) {
                        filteredUsers.add(user);
                      }
                    }

                    return Expanded(
                      child: UserGridList(
                        users: filteredUsers,
                        onPress: (user) {
                          List<CreateGroupchatUserFromCreateGroupchatDtoWithUserEntity>
                              newGroupchatUsers = List.from(
                            addGroupchatState.groupchatUsers ?? [],
                          )..add(
                                  CreateGroupchatUserFromCreateGroupchatDtoWithUserEntity(
                                    user: user,
                                  ),
                                );

                          BlocProvider.of<AddGroupchatCubit>(context).emitState(
                            groupchatUsers: newGroupchatUsers,
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
