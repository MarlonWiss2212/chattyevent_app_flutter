import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chattyevent_app_flutter/application/bloc/auth/auth_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/profile_page/profile_page_cubit.dart';
import 'package:chattyevent_app_flutter/domain/entities/user/user_entity.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/follow_button.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/user_list/user_list_tile.dart';

class ProfileFollowersTabListView extends StatelessWidget {
  final List<UserEntity> followers;
  final void Function() loadMore;
  final bool loading;
  final String profileUserId;

  const ProfileFollowersTabListView({
    super.key,
    required this.followers,
    required this.loadMore,
    required this.loading,
    required this.profileUserId,
  });

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          if (index < followers.length) {
            return UserListTile(
              user: followers[index],
              items: [
                if (BlocProvider.of<AuthCubit>(context).state.currentUser.id ==
                    profileUserId) ...{
                  PopupMenuItem(
                    child: const Text("Entfernen"),
                    onTap: () {
                      BlocProvider.of<ProfilePageCubit>(context).deleteFollower(
                        userId: followers[index].id,
                      );
                    },
                  ),
                },
              ],
              trailing: SizedBox(
                width: 90,
                height: 40,
                child: FollowButton(
                  user: followers[index],
                  onTap: () => BlocProvider.of<ProfilePageCubit>(context)
                      .followOrUnfollowUserViaApi(user: followers[index]),
                ),
              ),
            );
          }
          if (loading) {
            return const Center(child: CircularProgressIndicator.adaptive());
          } else {
            return IconButton(
              onPressed: loadMore,
              icon: const Icon(Icons.add_circle),
            );
          }
        },
        childCount: followers.length + 1,
      ),
    );
  }
}
