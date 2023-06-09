import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:chattyevent_app_flutter/application/bloc/profile_page/profile_page_cubit.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/screens/profile_page/profile_page/profile_page_circle_image.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/screens/profile_page/profile_page/profile_page_follow_button.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/screens/profile_page/profile_page/profile_page_follower_counts.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/screens/profile_page/profile_page/profile_page_title.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/screens/profile_page/profile_page/profile_page_trailing_buttons/profile_page_trailing_follow_request_icon_button.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/screens/profile_page/profile_page/profile_page_trailing_buttons/profile_page_trailing_settings_button.dart';

class ProfilePage extends StatelessWidget {
  final String? userId;

  const ProfilePage({super.key, @PathParam('id') this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            leading: userId != null ? const AutoLeadingButton() : null,
            pinned: true,
            snap: true,
            floating: true,
            expandedHeight: 100,
            centerTitle: true,
            flexibleSpace: const FlexibleSpaceBar(
              centerTitle: true,
              title: ProfilePageTitle(),
            ),
            actions: const [
              ProfilePageTrailingFollowRequestIconButton(),
              ProfilePageTrailingSettingsButton(),
            ],
          ),
          CupertinoSliverRefreshControl(
            onRefresh: () => BlocProvider.of<ProfilePageCubit>(context)
                .getCurrentUserViaApi(),
          ),
          BlocBuilder<ProfilePageCubit, ProfilePageState>(
            buildWhen: (previous, current) => previous.status != current.status,
            builder: (context, state) {
              if (state.user.id != "") {
                return SliverList(
                  delegate: SliverChildListDelegate(
                    const [
                      Center(child: ProfilePageCircleImage()),
                      SizedBox(height: 20),
                      ProfileFollowerCounts(),
                      SizedBox(height: 20),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: ProfilePageFollowButton(),
                      ),
                    ],
                  ),
                );
              } else if (state.status == ProfilePageStateStatus.loading &&
                  state.user.id == "") {
                return const SliverFillRemaining(
                  child: Center(
                    child: CircularProgressIndicator.adaptive(),
                  ),
                );
              } else {
                return SliverFillRemaining(
                  child: Center(
                    child: PlatformTextButton(
                      child: Text(
                        "Keinen User mit der Id: ${userId ?? state.user.id}",
                      ),
                      onPressed: () =>
                          BlocProvider.of<ProfilePageCubit>(context)
                              .getCurrentUserViaApi(),
                    ),
                  ),
                );
              }
            },
          )
        ],
      ),
    );
  }
}
