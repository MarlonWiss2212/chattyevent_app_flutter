import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chattyevent_app_flutter/application/bloc/profile_page/profile_page_cubit.dart';
import 'package:chattyevent_app_flutter/domain/entities/user/user_entity.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/user_list/user_list_tile.dart';
import 'package:ionicons/ionicons.dart';

class ProfileFollowRequestsTabListView extends StatelessWidget {
  final List<UserEntity> followRequests;
  final void Function() loadMore;
  final bool loading;
  const ProfileFollowRequestsTabListView({
    super.key,
    required this.followRequests,
    required this.loadMore,
    required this.loading,
  });

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          if (index < followRequests.length) {
            return UserListTile(
              user: followRequests[index],
              trailing: Wrap(
                spacing: 4,
                children: [
                  InkWell(
                    onTap: () {
                      BlocProvider.of<ProfilePageCubit>(context)
                          .acceptFollowRequest(
                        userId: followRequests[index].id,
                      );
                    },
                    borderRadius: BorderRadius.circular(8),
                    child: Ink(
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Theme.of(context).colorScheme.primaryContainer,
                        ),
                        child: Text(
                          "general.acceptText",
                          style: Theme.of(context).textTheme.labelMedium?.apply(
                                color: Colors.white,
                              ),
                        ).tr(),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      BlocProvider.of<ProfilePageCubit>(context)
                          .deleteFollowerOrRequest(
                        userId: followRequests[index].id,
                      );
                    },
                    borderRadius: BorderRadius.circular(8),
                    child: Ink(
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.black,
                        ),
                        child: Text(
                          "general.rejectText",
                          style: Theme.of(context).textTheme.labelMedium?.apply(
                                color: Colors.white,
                              ),
                        ).tr(),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
          if (loading) {
            return const Center(child: CircularProgressIndicator.adaptive());
          } else {
            return IconButton(
              onPressed: loadMore,
              icon: const Icon(Ionicons.arrow_down_circle_outline),
            );
          }
        },
        childCount: followRequests.length + 1,
      ),
    );
  }
}
