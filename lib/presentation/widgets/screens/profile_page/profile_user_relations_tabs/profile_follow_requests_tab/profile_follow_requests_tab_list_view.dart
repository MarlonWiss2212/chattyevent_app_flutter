import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chattyevent_app_flutter/application/bloc/profile_page/profile_page_cubit.dart';
import 'package:chattyevent_app_flutter/domain/entities/user/user_entity.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/user_list/user_list_tile.dart';

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
                          "Akzeptieren",
                          style: Theme.of(context).textTheme.labelMedium?.apply(
                                color: Colors.white,
                              ),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      BlocProvider.of<ProfilePageCubit>(context)
                          .deleteFollowRequest(
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
                          "Ablehnen",
                          style: Theme.of(context).textTheme.labelMedium?.apply(
                                color: Colors.white,
                              ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
          if (loading) {
            return const CircularProgressIndicator.adaptive();
          } else {
            return IconButton(
              onPressed: loadMore,
              icon: const Icon(Icons.add_circle),
            );
          }
        },
        childCount: followRequests.length + 1,
      ),
    );
  }
}
