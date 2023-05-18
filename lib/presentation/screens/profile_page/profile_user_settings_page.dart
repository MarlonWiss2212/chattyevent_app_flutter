import 'package:chattyevent_app_flutter/presentation/widgets/screens/profile_page/profile_user_settings_page/profile_user_settings_page_standard.dart';
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
        return ProfileUserSettingsPageStandard(
          title: Text(
            "Berechtigungen",
            style: TextStyle(
              color: Theme.of(context).colorScheme.onBackground,
            ),
          ),
          requesterGroupchatAddPermission: state.user.otherUserRelationToMyUser
              ?.followData?.requesterGroupchatAddPermission,
          requesterGroupchatAddPermissionOnChanged: (value) {
            BlocProvider.of<ProfilePageCubit>(context)
                .updateFollowDataCurrentProfileUserViaApi(
              updateUserRelationFollowDataDto: UpdateUserRelationFollowDataDto(
                requesterGroupchatAddPermission: value,
              ),
            );
          },
          requesterPrivateEventAddPermission: state
              .user
              .otherUserRelationToMyUser
              ?.followData
              ?.requesterPrivateEventAddPermission,
          requesterPrivateEventAddPermissionOnChanged: (value) {
            BlocProvider.of<ProfilePageCubit>(context)
                .updateFollowDataCurrentProfileUserViaApi(
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
