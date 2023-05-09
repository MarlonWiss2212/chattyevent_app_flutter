import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chattyevent_app_flutter/application/bloc/auth/auth_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/profile_page/profile_page_cubit.dart';
import 'package:chattyevent_app_flutter/presentation/router/router.gr.dart';

class ProfileUserRelationsTabPage extends StatelessWidget {
  final String? userId;

  const ProfileUserRelationsTabPage({
    super.key,
    @PathParam('id') this.userId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, authState) {
        return BlocBuilder<ProfilePageCubit, ProfilePageState>(
          buildWhen: (p, c) => p.user.id != c.user.id,
          builder: (context, state) {
            return AutoTabsRouter.tabBar(
              routes: [
                const ProfileFollowerTabRoute(),
                const ProfileFollowedTabRoute(),
                if (state.user.id == authState.currentUser.id ||
                    userId == null) ...{
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
                            state.user.username ?? "",
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        );
                      },
                    ),
                    bottom: TabBar(
                      controller: tabController,
                      tabs: [
                        const Tab(text: "Followers", icon: Icon(Icons.person)),
                        const Tab(
                            text: "Gefolgt",
                            icon: Icon(Icons.person_2_outlined)),
                        if (state.user.id == authState.currentUser.id ||
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
      },
    );
  }
}
