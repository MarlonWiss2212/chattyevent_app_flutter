import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:social_media_app_flutter/application/bloc/auth/auth_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/profile_page/profile_page_cubit.dart';
import 'package:social_media_app_flutter/presentation/router/router.gr.dart';

class ProfilePageTrailinSettingsButton extends StatelessWidget {
  const ProfilePageTrailinSettingsButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, authState) {
        return BlocBuilder<ProfilePageCubit, ProfilePageState>(
          builder: (context, state) {
            if (authState.currentUser.id == state.user.id) {
              return IconButton(
                onPressed: () => AutoRouter.of(context).push(
                  const SettingsWrapperPageRoute(),
                ),
                icon: Icon(PlatformIcons(context).settings),
              );
            }
            return const SizedBox();
          },
        );
      },
    );
  }
}
