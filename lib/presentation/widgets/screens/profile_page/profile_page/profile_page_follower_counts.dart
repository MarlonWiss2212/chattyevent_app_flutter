import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletons/skeletons.dart';
import 'package:chattyevent_app_flutter/application/bloc/profile_page/profile_page_cubit.dart';
import 'package:chattyevent_app_flutter/presentation/router/router.gr.dart';

class ProfileFollowerCounts extends StatelessWidget {
  const ProfileFollowerCounts({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: () => AutoRouter.of(context).push(
            const ProfileUserRelationsTabRoute(
              children: [
                ProfileFollowerTab(),
              ],
            ),
          ),
          child: Ink(
            padding: const EdgeInsets.all(8),
            child: BlocBuilder<ProfilePageCubit, ProfilePageState>(
              builder: (context, state) {
                return Column(
                  children: [
                    if (state.user.userRelationCounts?.followerCount == null &&
                        state.status == ProfilePageStateStatus.loading) ...{
                      const SkeletonLine(style: SkeletonLineStyle(width: 10))
                    } else ...{
                      Text(
                        state.user.userRelationCounts?.followerCount
                                ?.toString() ??
                            "0",
                      ),
                    },
                    const Text("Followers"),
                  ],
                );
              },
            ),
          ),
        ),
        InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: () => AutoRouter.of(context).push(
            const ProfileUserRelationsTabRoute(
              children: [
                ProfileFollowedTab(),
              ],
            ),
          ),
          child: Ink(
            padding: const EdgeInsets.all(8),
            child: BlocBuilder<ProfilePageCubit, ProfilePageState>(
              builder: (context, state) {
                return Column(
                  children: [
                    if (state.user.userRelationCounts?.followedCount == null &&
                        state.status == ProfilePageStateStatus.loading) ...{
                      const SkeletonLine(style: SkeletonLineStyle(width: 10))
                    } else ...{
                      Text(
                        state.user.userRelationCounts?.followedCount
                                ?.toString() ??
                            "0",
                      ),
                    },
                    const Text("Gefolgt"),
                  ],
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
