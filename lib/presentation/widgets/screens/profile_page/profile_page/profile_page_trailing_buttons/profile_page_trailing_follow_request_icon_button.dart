import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chattyevent_app_flutter/application/bloc/auth/auth_state.dart';
import 'package:chattyevent_app_flutter/application/bloc/profile_page/profile_page_cubit.dart';
import 'package:chattyevent_app_flutter/presentation/router/router.gr.dart';

class ProfilePageTrailingFollowRequestIconButton extends StatelessWidget {
  const ProfilePageTrailingFollowRequestIconButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      buildWhen: (p, c) => p.currentUser.id != c.currentUser.id,
      builder: (context, authState) {
        return BlocBuilder<ProfilePageCubit, ProfilePageState>(
          builder: (context, state) {
            if (authState.currentUser.id == state.user.id) {
              return IconButton(
                onPressed: () => AutoRouter.of(context).push(
                  const ProfileUserRelationsTabRoute(
                    children: [ProfileFollowRequestsTab()],
                  ),
                ),
                icon: Badge(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  label: Text(
                    state.user.userRelationCounts?.followRequestCount
                            ?.toString() ??
                        "0",
                  ),
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
