import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chattyevent_app_flutter/application/bloc/profile_page/profile_page_cubit.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/screens/profile_page/profile_user_relations_tabs/profile_followed_tab/profile_followed_tab_list_view.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/screens/profile_page/profile_user_relations_tabs/profile_followed_tab/profile_followed_tab_skeleton_list_view.dart';
import 'package:auto_route/auto_route.dart';

@RoutePage()
class ProfileFollowedTab extends StatefulWidget {
  const ProfileFollowedTab({super.key});

  @override
  State<ProfileFollowedTab> createState() => _ProfileFollowedTabState();
}

class _ProfileFollowedTabState extends State<ProfileFollowedTab> {
  @override
  void initState() {
    BlocProvider.of<ProfilePageCubit>(context).getFollowed();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        CupertinoSliverRefreshControl(
          onRefresh: () =>
              BlocProvider.of<ProfilePageCubit>(context).getFollowed(
            reload: true,
          ),
        ),
        BlocBuilder<ProfilePageCubit, ProfilePageState>(
          builder: (context, state) {
            if (state.followedStatus ==
                    ProfilePageStateFollowedStatus.loading &&
                state.followed.isEmpty) {
              return const ProfileFollowedTabSkeletonListView();
            }

            return ProfileFollowedTabListView(
              followed: state.followed,
              loadMore: () {
                BlocProvider.of<ProfilePageCubit>(context).getFollowed();
              },
              loading: state.followRequestsStatus ==
                  ProfilePageStateFollowRequestsStatus.loading,
            );
          },
        ),
      ],
    );
  }
}
