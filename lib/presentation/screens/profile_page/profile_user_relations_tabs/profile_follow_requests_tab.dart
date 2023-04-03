import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app_flutter/application/bloc/user/profile_page_cubit.dart';
import 'package:social_media_app_flutter/presentation/widgets/general/dialog/alert_dialog.dart';
import 'package:social_media_app_flutter/presentation/widgets/screens/profile_page/profile_user_relations_tabs/profile_follow_requests_tab/profile_follow_requests_tab_list_view.dart';
import 'package:social_media_app_flutter/presentation/widgets/screens/profile_page/profile_user_relations_tabs/profile_follow_requests_tab/profile_follow_requests_tab_skeleton_list_view.dart';

class ProfileFollowRequestsTab extends StatelessWidget {
  const ProfileFollowRequestsTab({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ProfilePageCubit>(context).getFollowRequests();

    return CustomScrollView(
      slivers: [
        CupertinoSliverRefreshControl(
          onRefresh: () =>
              BlocProvider.of<ProfilePageCubit>(context).getFollowRequests(
            reload: true,
          ),
        ),
        BlocConsumer<ProfilePageCubit, ProfilePageState>(
          listener: (context, state) async {
            if (state.followRequestsError != null &&
                state.followRequestsStatus ==
                    ProfilePageStateFollowRequestsStatus.error) {
              return await showDialog(
                context: context,
                builder: (c) {
                  return CustomAlertDialog(
                    title: state.followRequestsError!.title,
                    message: state.followRequestsError!.message,
                    context: c,
                  );
                },
              );
            }
          },
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
