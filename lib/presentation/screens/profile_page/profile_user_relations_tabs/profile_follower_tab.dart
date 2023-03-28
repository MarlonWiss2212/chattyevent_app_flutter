import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app_flutter/application/bloc/auth/auth_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/user/profile_page_cubit.dart';
import 'package:social_media_app_flutter/presentation/widgets/general/dialog/alert_dialog.dart';
import 'package:social_media_app_flutter/presentation/widgets/screens/profile_page/profile_user_relations_tabs/profile_followers_tab/profile_followers_tab_list_view.dart';
import 'package:social_media_app_flutter/presentation/widgets/screens/profile_page/profile_user_relations_tabs/profile_followers_tab/profile_followers_tab_skeleton_list_view.dart';

class ProfileFollowerTab extends StatelessWidget {
  const ProfileFollowerTab({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ProfilePageCubit>(context).getFollowers();

    return BlocConsumer<ProfilePageCubit, ProfilePageState>(
      listener: (context, state) async {
        if (state.followersError != null &&
            state.followersStatus == ProfilePageStateFollowersStatus.error) {
          return await showDialog(
            context: context,
            builder: (c) {
              return CustomAlertDialog(
                title: state.error!.title,
                message: state.error!.message,
                context: c,
              );
            },
          );
        }
      },
      builder: (context, state) {
        if (state.followersStatus == ProfilePageStateFollowersStatus.loading &&
                state.followers == null ||
            state.followers != null &&
                state.followersStatus ==
                    ProfilePageStateFollowersStatus.loading &&
                state.followers!.isEmpty) {
          return const ProfileFollowersTabSkeletonListView();
        }

        if (state.followers == null ||
            state.followers != null && state.followers!.isEmpty) {
          return const Center(child: Text("Keine Follower"));
        }

        return ProfileFollowersTabListView(
          isCurrentUsersProfilePage: state.user.id ==
              BlocProvider.of<AuthCubit>(context).state.currentUser.id,
          followers: state.followers ?? [],
        );
      },
    );
  }
}
