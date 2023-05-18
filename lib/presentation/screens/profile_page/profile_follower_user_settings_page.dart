import 'package:auto_route/auto_route.dart';
import 'package:chattyevent_app_flutter/core/enums/user_relation/requester_groupchat_add_permission_enum.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/screens/profile_page/profile_user_settings_page/profile_user_settings_page_standard.dart';
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

    return BlocBuilder<ProfilePageCubit, ProfilePageState>(
      builder: (context, state) {
        return ProfileUserSettingsPageStandard(
          title: Text(
            "${state.followers?[followerIndex].username} Berechtigungen",
            style: TextStyle(
              color: Theme.of(context).colorScheme.onBackground,
            ),
          ),
          requesterGroupchatAddPermission: state
              .followers?[followerIndex]
              .otherUserRelationToMyUser
              ?.followData
              ?.requesterGroupchatAddPermission,
          requesterGroupchatAddPermissionOnChanged: (value) {
            BlocProvider.of<ProfilePageCubit>(context)
                .updateFollowDataForFollowerViaApi(
              followerIndex: followerIndex,
              updateUserRelationFollowDataDto: UpdateUserRelationFollowDataDto(
                requesterGroupchatAddPermission: value,
              ),
            );
          },
          requesterPrivateEventAddPermission: state
              .followers?[followerIndex]
              .otherUserRelationToMyUser
              ?.followData
              ?.requesterPrivateEventAddPermission,
          requesterPrivateEventAddPermissionOnChanged: (value) {
            BlocProvider.of<ProfilePageCubit>(context)
                .updateFollowDataForFollowerViaApi(
              followerIndex: followerIndex,
              updateUserRelationFollowDataDto: UpdateUserRelationFollowDataDto(
                requesterPrivateEventAddPermission: value,
              ),
            );
          },
        );
      },
    );
  }
}
