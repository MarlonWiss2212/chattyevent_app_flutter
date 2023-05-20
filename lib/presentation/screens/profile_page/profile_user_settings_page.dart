import 'package:auto_route/auto_route.dart';
import 'package:chattyevent_app_flutter/core/enums/user_relation/requester_groupchat_add_permission_enum.dart';
import 'package:chattyevent_app_flutter/core/enums/user_relation/requester_private_event_add_permission_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chattyevent_app_flutter/application/bloc/profile_page/profile_page_cubit.dart';
import 'package:chattyevent_app_flutter/core/dto/user_relation/update_user_relation_follow_data_dto.dart';

class ProfileUserSettingsPage extends StatelessWidget {
  const ProfileUserSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfilePageCubit, ProfilePageState>(
      builder: (context, state) {
        return Scaffold(
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                leading: const AutoLeadingButton(),
                pinned: true,
                snap: true,
                floating: true,
                expandedHeight: 100,
                flexibleSpace: FlexibleSpaceBar(
                  title: Text(
                    "Berechtigungen",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate([
                  SwitchListTile.adaptive(
                    title: const Text("Darf dich in Gruppenchats adden"),
                    value: state.user.otherUserRelationToMyUser?.followData
                            ?.requesterGroupchatAddPermission ==
                        RequesterGroupchatAddPermissionEnum.add,
                    onChanged: (value) {
                      BlocProvider.of<ProfilePageCubit>(context)
                          .updateFollowDataCurrentProfileUserViaApi(
                        updateUserRelationFollowDataDto:
                            UpdateUserRelationFollowDataDto(
                          requesterGroupchatAddPermission: value
                              ? RequesterGroupchatAddPermissionEnum.add
                              : RequesterGroupchatAddPermissionEnum.none,
                        ),
                      );
                    },
                  ),
                  SwitchListTile.adaptive(
                    title: const Text("Darf dich in Events adden"),
                    value: state.user.otherUserRelationToMyUser?.followData
                            ?.requesterPrivateEventAddPermission ==
                        RequesterPrivateEventAddPermissionEnum.add,
                    onChanged: (value) {
                      BlocProvider.of<ProfilePageCubit>(context)
                          .updateFollowDataCurrentProfileUserViaApi(
                        updateUserRelationFollowDataDto:
                            UpdateUserRelationFollowDataDto(
                          requesterPrivateEventAddPermission: value
                              ? RequesterPrivateEventAddPermissionEnum.add
                              : RequesterPrivateEventAddPermissionEnum.none,
                        ),
                      );
                    },
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.remove,
                      color: Colors.red,
                    ),
                    title: const Text(
                      "Follower Entfernen",
                      style: TextStyle(color: Colors.red),
                    ),
                    onTap: () => BlocProvider.of<ProfilePageCubit>(context)
                        .deleteFollower(userId: state.user.id)
                        .then((value) => AutoRouter.of(context).pop()),
                  ),
                ]),
              ),
            ],
          ),
        );
      },
    );
  }
}
