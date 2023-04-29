import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app_flutter/application/bloc/auth/auth_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/profile_page/profile_page_cubit.dart';
import 'package:social_media_app_flutter/presentation/router/router.gr.dart';

class ProfilePageTrailingFollowRequestIconButton extends StatelessWidget {
  const ProfilePageTrailingFollowRequestIconButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, authState) {
        return BlocBuilder<ProfilePageCubit, ProfilePageState>(
          builder: (context, state) {
            if (authState.currentUser.id == state.user.id) {
              return IconButton(
                onPressed: () => AutoRouter.of(context).push(
                  ProfileUserRelationsTabPageRoute(children: const [
                    ProfileFollowRequestsTabRoute(),
                  ]),
                ),
                icon: Badge(
                  isLabelVisible:
                      state.user.userRelationCounts?.followRequestCount != null,
                  label: state.user.userRelationCounts?.followRequestCount !=
                          null
                      ? Text(state.user.userRelationCounts!.followRequestCount!
                          .toString())
                      : null,
                  child: const Icon(Icons.favorite),
                ),
              );
            }
            return const SizedBox();
          },
        );
      },
    );
  }
}
