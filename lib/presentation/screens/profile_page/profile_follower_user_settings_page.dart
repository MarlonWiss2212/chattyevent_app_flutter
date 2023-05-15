import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chattyevent_app_flutter/application/bloc/profile_page/profile_page_cubit.dart';
import 'package:chattyevent_app_flutter/core/dto/user_relation/update_user_relation_follow_data_dto.dart';

class ProfileFollowerUserSettingsPage extends StatelessWidget {
  final String followerIndexString;

  const ProfileFollowerUserSettingsPage({
    super.key,
    @PathParam('followerIndexString') required this.followerIndexString,
  });

  @override
  Widget build(BuildContext context) {
    final int followerIndex = int.parse(followerIndexString);
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
              title: BlocBuilder<ProfilePageCubit, ProfilePageState>(
                builder: (context, state) {
                  return Text(
                    "${state.followers?[followerIndex].username} Berechtigungen",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                  );
                },
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              BlocBuilder<ProfilePageCubit, ProfilePageState>(
                builder: (context, state) {
                  return SwitchListTile.adaptive(
                    title: const Text("Darf dich in Gruppenchats adden"),
                    value: state
                            .followers?[followerIndex]
                            .otherUserRelationToMyUser
                            ?.followData
                            ?.requesterGroupchatAddPermission ==
                        "ADD",
                    onChanged: (value) {
                      BlocProvider.of<ProfilePageCubit>(context)
                          .updateFollowDataForFollowerViaApi(
                        followerIndex: followerIndex,
                        updateUserRelationFollowDataDto:
                            UpdateUserRelationFollowDataDto(
                          requesterGroupchatAddPermission:
                              value ? "ADD" : "NONE",
                        ),
                      );
                    },
                  );
                },
              ),
              BlocBuilder<ProfilePageCubit, ProfilePageState>(
                builder: (context, state) {
                  return SwitchListTile.adaptive(
                    title: const Text("Darf dich in Events adden"),
                    value: state
                            .followers?[followerIndex]
                            .otherUserRelationToMyUser
                            ?.followData
                            ?.requesterPrivateEventAddPermission ==
                        "ADD",
                    onChanged: (value) {
                      BlocProvider.of<ProfilePageCubit>(context)
                          .updateFollowDataForFollowerViaApi(
                        followerIndex: followerIndex,
                        updateUserRelationFollowDataDto:
                            UpdateUserRelationFollowDataDto(
                          requesterPrivateEventAddPermission:
                              value ? "ADD" : "NONE",
                        ),
                      );
                    },
                  );
                },
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
