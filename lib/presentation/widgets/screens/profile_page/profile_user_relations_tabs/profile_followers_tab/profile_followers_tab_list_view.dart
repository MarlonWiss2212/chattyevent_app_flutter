import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app_flutter/application/bloc/auth/auth_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/profile_page/profile_page_cubit.dart';
import 'package:social_media_app_flutter/domain/entities/user/user_entity.dart';
import 'package:social_media_app_flutter/presentation/router/router.gr.dart';
import 'package:social_media_app_flutter/presentation/widgets/general/follow_button.dart';
import 'package:social_media_app_flutter/presentation/widgets/general/user_list/user_list_tile.dart';

class ProfileFollowersTabListView extends StatelessWidget {
  final List<UserEntity> followers;

  const ProfileFollowersTabListView({
    super.key,
    required this.followers,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfilePageCubit, ProfilePageState>(
      buildWhen: (p, c) => p.user.id != c.user.id,
      builder: (context, state) {
        return SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return UserListTile(
                user: followers[index],
                items: [
                  if (BlocProvider.of<AuthCubit>(context)
                          .state
                          .currentUser
                          .id ==
                      state.user.id) ...{
                    PopupMenuItem(
                      child: const Text("Entfernen"),
                      onTap: () {
                        BlocProvider.of<ProfilePageCubit>(context)
                            .deleteFollower(
                          userId: followers[index].id,
                        );
                      },
                    ),
                  },
                ],
                trailing: Wrap(
                  spacing: 8,
                  children: [
                    if (BlocProvider.of<AuthCubit>(context)
                            .state
                            .currentUser
                            .id ==
                        state.user.id) ...{
                      IconButton(
                        onPressed: () {
                          AutoRouter.of(context).push(
                            ProfileFollowerUserSettingsPageRoute(
                              followerIndexString: index.toString(),
                            ),
                          );
                        },
                        icon: const Icon(Icons.settings),
                      ),
                    },
                    SizedBox(
                      width: 90,
                      height: 40,
                      child: FollowButton(
                        user: followers[index],
                        onTap: () => BlocProvider.of<ProfilePageCubit>(context)
                            .followOrUnfollowUserViaApi(user: followers[index]),
                      ),
                    ),
                  ],
                ),
              );
            },
            childCount: followers.length,
          ),
        );
      },
    );
  }
}
