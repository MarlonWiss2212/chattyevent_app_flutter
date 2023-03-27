import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app_flutter/application/bloc/auth/auth_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/user/profile_page_cubit.dart';
import 'package:social_media_app_flutter/presentation/router/router.gr.dart';

class ProfileUserRelationsTabPage extends StatelessWidget {
  final String? userId;

  const ProfileUserRelationsTabPage({
    super.key,
    @PathParam('id') this.userId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      buildWhen: (previous, current) =>
          previous.currentUser.id != current.currentUser.id,
      builder: (context, authState) {
        return AutoTabsRouter.tabBar(
          routes: [
            const ProfileFollowerTabRoute(),
            const ProfileFollowedTabRoute(),
            if (userId == authState.currentUser.id || userId == null) ...{
              const ProfileFollowRequestsTabRoute(),
            }
          ],
          builder: (context, child, tabController) {
            return Scaffold(
              appBar: AppBar(
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
                bottom: TabBar(
                  controller: tabController,
                  indicatorColor: Theme.of(context).colorScheme.primary,
                  tabs: [
                    const Tab(text: "Followers", icon: Icon(Icons.person)),
                    const Tab(
                        text: "Gefolgt", icon: Icon(Icons.person_2_outlined)),
                    if (userId == authState.currentUser.id ||
                        userId == null) ...{
                      const Tab(
                        text: "Anfragen",
                        icon: Icon(Icons.front_hand),
                      ),
                    }
                  ],
                ),
              ),
              body: child,
            );
          },
        );
      },
    );
  }
}
