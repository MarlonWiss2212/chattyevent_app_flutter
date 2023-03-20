import 'package:flutter/material.dart';
import 'package:social_media_app_flutter/domain/entities/user/user_entity.dart';
import 'package:social_media_app_flutter/presentation/widgets/screens/profile_page/profile_user_relations_tabs/profile_followers_tab/profile_followers_tab_list_view_button_my_follower.dart';
import 'package:social_media_app_flutter/presentation/widgets/user_list/user_list_tile.dart';

class ProfileFollowersTabListView extends StatelessWidget {
  final bool isCurrentUsersProfilePage;
  final List<UserEntity> followers;

  const ProfileFollowersTabListView({
    super.key,
    required this.followers,
    required this.isCurrentUsersProfilePage,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return UserListTile(
          user: followers[index],
          trailing: SizedBox(
            width: 90,
            height: 40,
            child: ProfileFollowersTabListViewButtonMyFollower(
              isCurrentUsersProfilePage: isCurrentUsersProfilePage,
              user: followers[index],
            ),
          ),
        );
      },
      itemCount: followers.length,
    );
  }
}
