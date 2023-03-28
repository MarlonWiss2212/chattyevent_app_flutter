import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app_flutter/application/bloc/user/profile_page_cubit.dart';
import 'package:social_media_app_flutter/presentation/widgets/general/dialog/alert_dialog.dart';
import 'package:social_media_app_flutter/presentation/widgets/screens/profile_page/profile_user_relations_tabs/profile_followed_tab/profile_followed_tab_list_view.dart';
import 'package:social_media_app_flutter/presentation/widgets/screens/profile_page/profile_user_relations_tabs/profile_followed_tab/profile_followed_tab_skeleton_list_view.dart';

class ProfileFollowedTab extends StatelessWidget {
  const ProfileFollowedTab({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ProfilePageCubit>(context).getFollowed();

    return BlocConsumer<ProfilePageCubit, ProfilePageState>(
      listener: (context, state) async {
        if (state.followedError != null &&
            state.followedStatus == ProfilePageStateFollowedStatus.error) {
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
      //   buildWhen: (previous, current) =>
      //       previous.userRelations?.length != current.userRelations?.length,
      builder: (context, state) {
        if (state.followedStatus == ProfilePageStateFollowedStatus.loading &&
                state.followed == null ||
            state.followedStatus == ProfilePageStateFollowedStatus.loading &&
                state.followed != null &&
                state.followed!.isEmpty) {
          return const ProfileFollowedTabSkeletonListView();
        }

        if (state.followed == null ||
            state.followed != null && state.followed!.isEmpty) {
          return const Center(child: Text("Keinem Gefolgt"));
        }

        return ProfileFollowedTabListView(
          followed: state.followed ?? [],
        );
      },
    );
  }
}
