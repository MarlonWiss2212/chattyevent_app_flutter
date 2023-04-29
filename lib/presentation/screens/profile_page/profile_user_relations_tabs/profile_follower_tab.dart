import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app_flutter/application/bloc/profile_page/profile_page_cubit.dart';
import 'package:social_media_app_flutter/presentation/widgets/general/dialog/alert_dialog.dart';
import 'package:social_media_app_flutter/presentation/widgets/screens/profile_page/profile_user_relations_tabs/profile_followers_tab/profile_followers_tab_list_view.dart';
import 'package:social_media_app_flutter/presentation/widgets/screens/profile_page/profile_user_relations_tabs/profile_followers_tab/profile_followers_tab_skeleton_list_view.dart';

class ProfileFollowerTab extends StatelessWidget {
  const ProfileFollowerTab({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ProfilePageCubit>(context).getFollowers();

    return CustomScrollView(
      slivers: [
        CupertinoSliverRefreshControl(
          onRefresh: () =>
              BlocProvider.of<ProfilePageCubit>(context).getFollowers(
            reload: true,
          ),
        ),
        BlocBuilder<ProfilePageCubit, ProfilePageState>(
          builder: (context, state) {
            if (state.followersStatus ==
                        ProfilePageStateFollowersStatus.loading &&
                    state.followers == null ||
                state.followers != null &&
                    state.followersStatus ==
                        ProfilePageStateFollowersStatus.loading &&
                    state.followers!.isEmpty) {
              return const ProfileFollowersTabSkeletonListView();
            }

            if (state.followers == null ||
                state.followers != null && state.followers!.isEmpty) {
              return const SliverFillRemaining(
                child: Center(
                  child: Text(
                    "Keine Follower",
                  ),
                ),
              );
            }

            return ProfileFollowersTabListView(
              followers: state.followers ?? [],
            );
          },
        ),
      ],
    );
  }
}
