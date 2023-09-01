import 'package:auto_route/auto_route.dart';
import 'package:chattyevent_app_flutter/presentation/router/router.gr.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/custom_tab_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chattyevent_app_flutter/application/bloc/auth/auth_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/profile_page/profile_page_cubit.dart';

@RoutePage()
class ProfileUserRelationsTabPage extends StatelessWidget {
  const ProfileUserRelationsTabPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      buildWhen: (p, c) => p.currentUser.id != c.currentUser.id,
      builder: (context, authState) {
        return BlocBuilder<ProfilePageCubit, ProfilePageState>(
          buildWhen: (p, c) => p.user.id != c.user.id,
          builder: (context, state) {
            return AutoTabsRouter.tabBar(
              routes: [
                // had route before
                const ProfileFollowerTab(),
                const ProfileFollowedTab(),
                if (state.user.id == authState.currentUser.id) ...{
                  const ProfileFollowRequestsTab(),
                }
              ],
              builder: (context, child, tabController) {
                return Scaffold(
                  appBar: AppBar(
                    centerTitle: true,
                    title: BlocBuilder<ProfilePageCubit, ProfilePageState>(
                      buildWhen: (previous, current) {
                        return previous.user.username != current.user.username;
                      },
                      builder: (context, state) {
                        return Hero(
                          tag: "${state.user.id} username",
                          child: Text(
                            state.user.username ?? "",
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        );
                      },
                    ),
                  ),
                  body: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: CustomTabBar(
                          controller: tabController,
                          tabs: [
                            const Tab(
                                text: "Followers", icon: Icon(Icons.person)),
                            const Tab(
                                text: "Gefolgt",
                                icon: Icon(Icons.person_2_outlined)),
                            if (state.user.id == authState.currentUser.id) ...{
                              const Tab(
                                text: "Anfragen",
                                icon: Icon(Icons.front_hand),
                              ),
                            }
                          ],
                        ),
                      ),
                      Expanded(child: child),
                    ],
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
