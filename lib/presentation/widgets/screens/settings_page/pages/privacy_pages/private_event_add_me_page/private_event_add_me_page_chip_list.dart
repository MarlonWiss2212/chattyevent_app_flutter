import 'package:chattyevent_app_flutter/application/bloc/auth/auth_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/user_search/user_search_cubit.dart';
import 'package:chattyevent_app_flutter/core/enums/user/private_event_add_me_permission_enum.dart';
import 'package:chattyevent_app_flutter/infastructure/dto/user/update_user_dto.dart';
import 'package:chattyevent_app_flutter/infastructure/dto/user/update_user_permissions.dart';
import 'package:chattyevent_app_flutter/infastructure/dto/user/update_user_permissions/update_private_event_add_me_dto.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/custom_chip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';

class PrivateEventAddMePageChipList extends StatelessWidget {
  const PrivateEventAddMePageChipList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      buildWhen: (p, c) =>
          p.currentUser.permissions?.privateEventAddMe?.permission !=
          c.currentUser.permissions?.privateEventAddMe?.permission,
      builder: (context, state) {
        final permissionIsNone =
            state.currentUser.permissions?.privateEventAddMe?.permission ==
                PrivateEventAddMePermissionEnum.none;

        final permissionIsOnlySelectedFollowers =
            state.currentUser.permissions?.privateEventAddMe?.permission ==
                PrivateEventAddMePermissionEnum.onlySelectedFollowers;

        final permissionIsFollowersExcept =
            state.currentUser.permissions?.privateEventAddMe?.permission ==
                PrivateEventAddMePermissionEnum.followersExcept;

        return SizedBox(
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
                        privateEventAddMe: UpdatePrivateEventAddMeDto(
                          permission: PrivateEventAddMePermissionEnum.none,
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
                  text: const Text("Niemand"),
                ),
                CustomChip(
                  onTap: () => BlocProvider.of<AuthCubit>(context)
                      .updateUser(
                        updateUserDto: UpdateUserDto(
                          permissions: UpdateUserPermissionsDto(
                            privateEventAddMe: UpdatePrivateEventAddMeDto(
                              permission: PrivateEventAddMePermissionEnum
                                  .followersExcept,
                            ),
                          ),
                        ),
                      )
                      .then(
                        (value) => BlocProvider.of<UserSearchCubit>(context)
                            .getFollowersViaApi(
                          sortForPrivateEventAddMeAllowedUsersFirst: true,
                        ),
                      ),
                  color: permissionIsFollowersExcept
                      ? Theme.of(context).colorScheme.primaryContainer
                      : Theme.of(context).colorScheme.surface,
                  leadingIcon: permissionIsFollowersExcept
                      ? const Icon(Ionicons.checkmark, size: 13)
                      : null,
                  text: const Text("Follower außer"),
                ),
                CustomChip(
                  onTap: () => BlocProvider.of<AuthCubit>(context)
                      .updateUser(
                        updateUserDto: UpdateUserDto(
                          permissions: UpdateUserPermissionsDto(
                            privateEventAddMe: UpdatePrivateEventAddMeDto(
                              permission: PrivateEventAddMePermissionEnum
                                  .onlySelectedFollowers,
                            ),
                          ),
                        ),
                      )
                      .then(
                        (value) => BlocProvider.of<UserSearchCubit>(context)
                            .getFollowersViaApi(
                          sortForPrivateEventAddMeAllowedUsersFirst: true,
                        ),
                      ),
                  color: permissionIsOnlySelectedFollowers
                      ? Theme.of(context).colorScheme.primaryContainer
                      : Theme.of(context).colorScheme.surface,
                  leadingIcon: permissionIsOnlySelectedFollowers
                      ? const Icon(Ionicons.checkmark, size: 13)
                      : null,
                  text: const Text("Nur diese Follower"),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}