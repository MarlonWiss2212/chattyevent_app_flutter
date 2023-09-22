import 'package:chattyevent_app_flutter/application/bloc/auth/auth_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/user_search/user_search_cubit.dart';
import 'package:chattyevent_app_flutter/core/enums/user/calendar_watch_i_have_time_permission_enum.dart';
import 'package:chattyevent_app_flutter/infastructure/dto/user/update_user_dto.dart';
import 'package:chattyevent_app_flutter/infastructure/dto/user/update_user_permissions.dart';
import 'package:chattyevent_app_flutter/infastructure/dto/user/update_user_permissions/update_calendar_watch_i_have_time_dto.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/custom_chip.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';

class CalendarWatchIHaveTimePageChipList extends StatelessWidget {
  const CalendarWatchIHaveTimePageChipList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      buildWhen: (p, c) =>
          p.currentUser.permissions?.calendarWatchIHaveTime?.permission !=
          c.currentUser.permissions?.calendarWatchIHaveTime?.permission,
      builder: (context, state) {
        final permissionIsNone =
            state.currentUser.permissions?.calendarWatchIHaveTime?.permission ==
                CalendarWatchIHaveTimePermissionEnum.none;

        final permissionIsOnlySelectedFollowers =
            state.currentUser.permissions?.calendarWatchIHaveTime?.permission ==
                CalendarWatchIHaveTimePermissionEnum.onlySelectedFollowers;

        final permissionIsFollowersExcept =
            state.currentUser.permissions?.calendarWatchIHaveTime?.permission ==
                CalendarWatchIHaveTimePermissionEnum.followersExcept;

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          height: 40,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Wrap(
              spacing: 8,
              children: [
                CustomChip(
                  onTap: () => BlocProvider.of<AuthCubit>(context).updateUser(
                    updateUserDto: UpdateUserDto(
                      permissions: UpdateUserPermissionsDto(
                        calendarWatchIHaveTime: UpdateCalendarWatchIHaveTimeDto(
                          permission: CalendarWatchIHaveTimePermissionEnum.none,
                        ),
                      ),
                    ),
                  ),
                  color: permissionIsNone
                      ? Theme.of(context).colorScheme.primaryContainer
                      : Theme.of(context).colorScheme.surface,
                  leadingIcon: permissionIsNone
                      ? const Icon(Ionicons.checkmark, size: 13)
                      : null,
                  text: const Text(
                    "settingsPage.privacyPage.chipTitles.noone",
                  ).tr(),
                ),
                CustomChip(
                  onTap: () async {
                    BlocProvider.of<AuthCubit>(context)
                        .updateUser(
                          updateUserDto: UpdateUserDto(
                            permissions: UpdateUserPermissionsDto(
                              calendarWatchIHaveTime:
                                  UpdateCalendarWatchIHaveTimeDto(
                                permission: CalendarWatchIHaveTimePermissionEnum
                                    .followersExcept,
                              ),
                            ),
                          ),
                        )
                        .then(
                          (value) => BlocProvider.of<UserSearchCubit>(context)
                              .getFollowersViaApi(
                            sortForCalendarWatchIHaveTimeAllowedUsersFirst:
                                true,
                          ),
                        );
                  },
                  color: permissionIsFollowersExcept
                      ? Theme.of(context).colorScheme.primaryContainer
                      : Theme.of(context).colorScheme.surface,
                  leadingIcon: permissionIsFollowersExcept
                      ? const Icon(Ionicons.checkmark, size: 13)
                      : null,
                  text: const Text(
                    "settingsPage.privacyPage.chipTitles.followersExcept",
                  ).tr(),
                ),
                CustomChip(
                  onTap: () => BlocProvider.of<AuthCubit>(context)
                      .updateUser(
                        updateUserDto: UpdateUserDto(
                          permissions: UpdateUserPermissionsDto(
                            calendarWatchIHaveTime:
                                UpdateCalendarWatchIHaveTimeDto(
                              permission: CalendarWatchIHaveTimePermissionEnum
                                  .onlySelectedFollowers,
                            ),
                          ),
                        ),
                      )
                      .then(
                        (value) => BlocProvider.of<UserSearchCubit>(context)
                            .getFollowersViaApi(
                          sortForCalendarWatchIHaveTimeAllowedUsersFirst: true,
                        ),
                      ),
                  color: permissionIsOnlySelectedFollowers
                      ? Theme.of(context).colorScheme.primaryContainer
                      : Theme.of(context).colorScheme.surface,
                  leadingIcon: permissionIsOnlySelectedFollowers
                      ? const Icon(Ionicons.checkmark, size: 13)
                      : null,
                  text: const Text(
                    "settingsPage.privacyPage.chipTitles.onlyTheseFollowers",
                  ).tr(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
