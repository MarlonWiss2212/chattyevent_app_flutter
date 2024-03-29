import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chattyevent_app_flutter/application/bloc/profile_page/profile_page_cubit.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/screens/profile_page/profile_user_relations_tabs/profile_follow_requests_tab/profile_follow_requests_tab_list_view.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/screens/profile_page/profile_user_relations_tabs/profile_follow_requests_tab/profile_follow_requests_tab_skeleton_list_view.dart';
import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';

@RoutePage()
class ProfileFollowRequestsTab extends StatefulWidget {
  const ProfileFollowRequestsTab({super.key});

  @override
  State<ProfileFollowRequestsTab> createState() =>
      _ProfileFollowRequestsTabState();
}

class _ProfileFollowRequestsTabState extends State<ProfileFollowRequestsTab> {
  @override
  void initState() {
    BlocProvider.of<ProfilePageCubit>(context).getFollowRequests();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        CupertinoSliverRefreshControl(
          onRefresh: () =>
              BlocProvider.of<ProfilePageCubit>(context).getFollowRequests(
            reload: true,
          ),
        ),
        BlocBuilder<ProfilePageCubit, ProfilePageState>(
          builder: (context, state) {
            if (state.followRequestsStatus ==
                    ProfilePageStateFollowRequestsStatus.loading &&
                state.followRequests.isEmpty) {
              return const ProfileFollowRequestsTabSkeletonListView();
            }

            if (state.followRequests.isEmpty) {
              return SliverFillRemaining(
                child: Center(
                  child: const Text(
                          "profilePage.userRelationsTabs.followRequestsTab.noFollowRequestsText")
                      .tr(),
                ),
              );
            }

            return ProfileFollowRequestsTabListView(
              followRequests: state.followRequests,
              loadMore: () {
                BlocProvider.of<ProfilePageCubit>(context).getFollowRequests();
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
