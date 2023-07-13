import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chattyevent_app_flutter/application/bloc/profile_page/profile_page_cubit.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/screens/profile_page/profile_user_relations_tabs/profile_followers_tab/profile_followers_tab_list_view.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/screens/profile_page/profile_user_relations_tabs/profile_followers_tab/profile_followers_tab_skeleton_list_view.dart';
import 'package:auto_route/auto_route.dart';

@RoutePage()
class ProfileFollowerTab extends StatefulWidget {
  const ProfileFollowerTab({super.key});

  @override
  State<ProfileFollowerTab> createState() => _ProfileFollowerTabState();
}

class _ProfileFollowerTabState extends State<ProfileFollowerTab> {
  @override
  void initState() {
    BlocProvider.of<ProfilePageCubit>(context).getFollowers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                state.followers.isEmpty) {
              return const ProfileFollowersTabSkeletonListView();
            }

            return ProfileFollowersTabListView(
              followers: state.followers,
              loadMore: () {
                BlocProvider.of<ProfilePageCubit>(context).getFollowers();
              },
              profileUserId: state.user.id,
              loading: state.followRequestsStatus ==
                  ProfilePageStateFollowRequestsStatus.loading,
            );
          },
        ),
      ],
    );
  }
}
