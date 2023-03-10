import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:social_media_app_flutter/application/bloc/auth/auth_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/user/profile_page_cubit.dart';
import 'package:social_media_app_flutter/presentation/router/router.gr.dart';
import 'package:social_media_app_flutter/presentation/widgets/screens/profile_page/profile_page_data.dart';
import 'package:social_media_app_flutter/presentation/widgets/screens/profile_page/profile_page_trailing_buttons/profile_page_trailing_follow_request_icon_button.dart';
import 'package:social_media_app_flutter/presentation/widgets/screens/profile_page/profile_page_trailing_buttons/profile_page_trailing_settings_button.dart';

class ProfilePage extends StatelessWidget {
  final String? userId;

  const ProfilePage({super.key, @PathParam('id') this.userId});

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      appBar: PlatformAppBar(
        leading: userId != null ? const AutoLeadingButton() : null,
        title: BlocBuilder<ProfilePageCubit, ProfilePageState>(
          buildWhen: (previous, current) {
            return previous.user.username != current.user.username;
          },
          builder: (context, state) {
            return Hero(
              tag: "${userId ?? state.user.id} username",
              child: Text(
                state.user.username ?? "Profilseite",
                style: Theme.of(context).textTheme.titleLarge,
              ),
            );
          },
        ),
        trailingActions: const [
          ProfilePageTrailingFollowRequestIconButton(),
          ProfilePageTrailinSettingsButton(),
        ],
      ),
      body: BlocBuilder<ProfilePageCubit, ProfilePageState>(
        buildWhen: (previous, current) => previous.status != current.status,
        builder: (context, state) {
          Widget content;

          if (state.user.id != "") {
            content = const ProfilePageData();
          } else if (state.status == ProfilePageStateStatus.loading &&
              state.user.id == "") {
            content = Center(child: PlatformCircularProgressIndicator());
          } else {
            content = Center(
              child: PlatformTextButton(
                child: Text(
                  "Keinen User mit der Id: ${userId ?? state.user.id}",
                ),
                onPressed: () => BlocProvider.of<ProfilePageCubit>(context)
                    .getCurrentUserViaApi(),
              ),
            );
          }
          return Column(
            children: [
              if (state.status == ProfilePageStateStatus.loading &&
                  state.user.id != "") ...{const LinearProgressIndicator()},
              Expanded(child: content),
            ],
          );
        },
      ),
    );
  }
}
