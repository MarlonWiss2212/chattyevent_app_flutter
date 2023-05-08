import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chattyevent_app_flutter/application/bloc/profile_page/profile_page_cubit.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/screens/profile_page/profile_user_relations_tabs/profile_follow_requests_tab/profile_follow_requests_tab_list_view.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/screens/profile_page/profile_user_relations_tabs/profile_follow_requests_tab/profile_follow_requests_tab_skeleton_list_view.dart';

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
            if (state.followRequests != null &&
                    state.followRequestsStatus ==
                        ProfilePageStateFollowRequestsStatus.loading &&
                    state.followRequests!.isEmpty ||
                state.followRequestsStatus ==
                        ProfilePageStateFollowRequestsStatus.loading &&
                    state.followRequests == null) {
              return const ProfileFollowRequestsTabSkeletonListView();
            }

            if (state.followRequests == null ||
                state.followRequests != null && state.followRequests!.isEmpty) {
              return const SliverFillRemaining(
                child: Center(
                  child: Text("Keine Freundschaftsanfragen"),
                ),
              );
            }

            return ProfileFollowRequestsTabListView(
              followRequests: state.followRequests ?? [],
            );
          },
        ),
      ],
    );
  }
}
