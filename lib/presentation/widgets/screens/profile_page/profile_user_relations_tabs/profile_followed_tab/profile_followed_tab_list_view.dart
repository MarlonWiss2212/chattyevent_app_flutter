import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app_flutter/application/bloc/user/profile_page_cubit.dart';
import 'package:social_media_app_flutter/domain/entities/user/user_entity.dart';
import 'package:social_media_app_flutter/presentation/widgets/general/follow_button.dart';
import 'package:social_media_app_flutter/presentation/widgets/general/user_list/user_list_tile.dart';

class ProfileFollowedTabListView extends StatelessWidget {
  final List<UserEntity> followed;

  const ProfileFollowedTabListView({super.key, required this.followed});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return UserListTile(
          user: followed[index],
          trailing: SizedBox(
            width: 90,
            height: 40,
            child: FollowButton(
              user: followed[index],
              onTap: () {
                BlocProvider.of<ProfilePageCubit>(context)
                    .followOrUnfollowUserViaApi(
                  user: followed[index],
                );
              },
            ),
          ),
        );
      },
      itemCount: followed.length,
    );
  }
}
