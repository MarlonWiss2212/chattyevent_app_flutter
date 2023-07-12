import 'package:chattyevent_app_flutter/application/bloc/auth/auth_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/user_search/user_search_cubit.dart';
import 'package:chattyevent_app_flutter/core/enums/user/groupchat_add_me_permission_enum.dart';
import 'package:chattyevent_app_flutter/infastructure/dto/user/update_user_dto.dart';
import 'package:chattyevent_app_flutter/infastructure/dto/user/update_user_permissions.dart';
import 'package:chattyevent_app_flutter/infastructure/dto/user/update_user_permissions/update_groupchat_add_me_dto.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/user_list/user_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletons/skeletons.dart';

class GroupchatAddMePageUserList extends StatelessWidget {
  const GroupchatAddMePageUserList({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, authState) {
          return BlocBuilder<UserSearchCubit, UserSearchState>(
            builder: (context, state) {
              if (authState
                      .currentUser.permissions?.groupchatAddMe?.permission ==
                  GroupchatAddMePermissionEnum.none) {
                return const Center(
                    child: Text("Keine User können gewählt werden"));
              }
              if (state.users.isEmpty) {
                return const Center(child: Text("Keine User gefunden"));
              }

              if (authState.currentUser.permissions?.groupchatAddMe
                          ?.permission ==
                      null ||
                  authState.currentUser.permissions?.groupchatAddMe
                          ?.selectedUserIds ==
                      null ||
                  authState.currentUser.permissions?.groupchatAddMe
                          ?.exceptUserIds ==
                      null) {
                return const Center(
                  child: Text(
                    "Kann keine User nicht darstellen da die berechtigungen nich geladen werden konnten",
                  ),
                );
              }
              if (state.status == UserSearchStateStatus.loading) {
                return SkeletonListView(
                  spacing: 0,
                  itemBuilder: (p0, p1) {
                    return SkeletonListTile(
                      hasSubtitle: true,
                      titleStyle:
                          const SkeletonLineStyle(width: 100, height: 22),
                      subtitleStyle: const SkeletonLineStyle(
                          width: double.infinity, height: 16),
                      leadingStyle: const SkeletonAvatarStyle(
                        shape: BoxShape.circle,
                      ),
                    );
                  },
                );
              }
              return ListView.builder(
                itemBuilder: (context, index) => itemBuilder(
                  context,
                  index,
                  authState,
                  state,
                ),
                itemCount: state.users.length + 1,
              );
            },
          );
        },
      ),
    );
  }

  Widget itemBuilder(
    BuildContext context,
    int index,
    AuthState authState,
    UserSearchState state,
  ) {
    if (index >= state.users.length) {
      if (state.status == UserSearchStateStatus.loadingMore) {
        return const Center(child: CircularProgressIndicator.adaptive());
      } else {
        return IconButton(
          onPressed: () {
            BlocProvider.of<UserSearchCubit>(context).getFollowersViaApi(
              loadMore: true,
              sortForGroupchatAddMeAllowedUsersFirst: true,
            );
          },
          icon: const Icon(Icons.add_circle),
        );
      }
    }

    bool value = false;
    switch (authState.currentUser.permissions!.groupchatAddMe!.permission!) {
      case GroupchatAddMePermissionEnum.none:
        break;
      case GroupchatAddMePermissionEnum.followersExcept:
        if (authState.currentUser.permissions!.groupchatAddMe!.exceptUserIds!
            .contains(state.users[index].id)) {
          value = true;
        }
        break;
      case GroupchatAddMePermissionEnum.onlySelectedFollowers:
        if (authState.currentUser.permissions!.groupchatAddMe!.selectedUserIds!
            .contains(state.users[index].id)) {
          value = true;
        }
        break;
    }
    return UserListTile(
      user: state.users[index],
      trailing: Checkbox(
        value: value,
        onChanged: (value) {
          UpdateGroupchatAddMeDto? dto;
          if (value == null) {
            return;
          }
          switch (
              authState.currentUser.permissions!.groupchatAddMe!.permission!) {
            case GroupchatAddMePermissionEnum.none:
              break;
            case GroupchatAddMePermissionEnum.followersExcept:
              if (value == true) {
                dto = UpdateGroupchatAddMeDto(
                  addToExceptUserIds: [state.users[index].id],
                );
              } else {
                dto = UpdateGroupchatAddMeDto(
                  removeFromExceptUserIds: [state.users[index].id],
                );
              }
              break;
            case GroupchatAddMePermissionEnum.onlySelectedFollowers:
              if (value == true) {
                dto = UpdateGroupchatAddMeDto(
                  addToSelectedUserIds: [state.users[index].id],
                );
              } else {
                dto = UpdateGroupchatAddMeDto(
                  removeFromSelectedUserIds: [state.users[index].id],
                );
              }
              break;
          }
          if (dto == null) return;
          BlocProvider.of<AuthCubit>(context).updateUser(
            updateUserDto: UpdateUserDto(
              permissions: UpdateUserPermissionsDto(
                groupchatAddMe: dto,
              ),
            ),
          );
        },
      ),
    );
  }
}
