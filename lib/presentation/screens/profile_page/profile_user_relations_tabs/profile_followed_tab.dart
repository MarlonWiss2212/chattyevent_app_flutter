import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:social_media_app_flutter/application/bloc/user/profile_page_cubit.dart';
import 'package:social_media_app_flutter/presentation/widgets/dialog/buttons/ok_button.dart';
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
          return await showPlatformDialog(
            context: context,
            builder: (context) {
              return PlatformAlertDialog(
                title: Text(state.followedError!.title),
                content: Text(state.followedError!.message),
                actions: const [OKButton()],
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
          return const Center(child: Text("Du Folgst keinem"));
        }

        return ProfileFollowedTabListView(
          followed: state.followed ?? [],
        );
      },
    );
  }
}
