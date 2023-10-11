import 'package:chattyevent_app_flutter/application/bloc/auth/auth_state.dart';
import 'package:chattyevent_app_flutter/application/bloc/user_search/user_search_cubit.dart';
import 'package:chattyevent_app_flutter/core/enums/user/calendar_watch_i_have_time_permission_enum.dart';
import 'package:chattyevent_app_flutter/infastructure/dto/user/update_user_dto.dart';
import 'package:chattyevent_app_flutter/infastructure/dto/user/update_user_permissions.dart';
import 'package:chattyevent_app_flutter/infastructure/dto/user/update_user_permissions/update_calendar_watch_i_have_time_dto.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/user_list/user_list_tile.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import 'package:skeletons/skeletons.dart';

class CalendarWatchIHaveTimePageUserList extends StatelessWidget {
  const CalendarWatchIHaveTimePageUserList({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, authState) {
          return BlocBuilder<UserSearchCubit, UserSearchState>(
            builder: (context, state) {
              if (authState.currentUser.permissions?.calendarWatchIHaveTime
                      ?.permission ==
                  CalendarWatchIHaveTimePermissionEnum.none) {
                return Center(
                  child: const Text(
                    "settingsPage.privacyPage.userListTexts.noUsersCanBeSelected",
                  ).tr(),
                );
              }
              if (state.users.isEmpty) {
                return Center(
                  child: const Text("general.userSearch.noUsersFoundText").tr(),
                );
              }

              if (authState.currentUser.permissions?.calendarWatchIHaveTime
                          ?.permission ==
                      null ||
                  authState.currentUser.permissions?.calendarWatchIHaveTime
                          ?.selectedUserIds ==
                      null ||
                  authState.currentUser.permissions?.calendarWatchIHaveTime
                          ?.exceptUserIds ==
                      null) {
                return Center(
                  child: const Text(
                    "settingsPage.privacyPage.userListTexts.couldntLoadUsersDueToPermission",
                  ).tr(),
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
              sortForCalendarWatchIHaveTimeAllowedUsersFirst: true,
            );
          },
          icon: const Icon(Ionicons.arrow_down_circle_outline),
        );
      }
    }

    bool value = false;
    switch (authState
        .currentUser.permissions!.calendarWatchIHaveTime!.permission!) {
      case CalendarWatchIHaveTimePermissionEnum.none:
        break;
      case CalendarWatchIHaveTimePermissionEnum.followersExcept:
        if (authState
            .currentUser.permissions!.calendarWatchIHaveTime!.exceptUserIds!
            .contains(state.users[index].id)) {
          value = true;
        }
        break;
      case CalendarWatchIHaveTimePermissionEnum.onlySelectedFollowers:
        if (authState
            .currentUser.permissions!.calendarWatchIHaveTime!.selectedUserIds!
            .contains(state.users[index].id)) {
          value = true;
        }
        break;
    }
    return UserListTile(
      key: ObjectKey(state.users[index]),
      user: state.users[index],
      trailing: Checkbox(
        value: value,
        onChanged: (value) {
          UpdateCalendarWatchIHaveTimeDto? dto;
          if (value == null) {
            return;
          }
          switch (authState
              .currentUser.permissions!.calendarWatchIHaveTime!.permission!) {
            case CalendarWatchIHaveTimePermissionEnum.none:
              break;
            case CalendarWatchIHaveTimePermissionEnum.followersExcept:
              if (value == true) {
                dto = UpdateCalendarWatchIHaveTimeDto(
                  addToExceptUserIds: [state.users[index].id],
                );
              } else {
                dto = UpdateCalendarWatchIHaveTimeDto(
                  removeFromExceptUserIds: [state.users[index].id],
                );
              }
              break;
            case CalendarWatchIHaveTimePermissionEnum.onlySelectedFollowers:
              if (value == true) {
                dto = UpdateCalendarWatchIHaveTimeDto(
                  addToSelectedUserIds: [state.users[index].id],
                );
              } else {
                dto = UpdateCalendarWatchIHaveTimeDto(
                  removeFromSelectedUserIds: [state.users[index].id],
                );
              }
              break;
          }
          if (dto == null) return;
          BlocProvider.of<AuthCubit>(context).updateUser(
            updateUserDto: UpdateUserDto(
              permissions: UpdateUserPermissionsDto(
                calendarWatchIHaveTime: dto,
              ),
            ),
          );
        },
      ),
    );
  }
}
