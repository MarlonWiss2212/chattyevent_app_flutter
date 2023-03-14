import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app_flutter/application/bloc/user/profile_page_cubit.dart';
import 'package:social_media_app_flutter/domain/entities/user/user_entity.dart';
import 'package:social_media_app_flutter/presentation/widgets/general/follow_button.dart';

class ProfileFollowersTabListViewButtonMyFollower extends StatelessWidget {
  final bool isCurrentUsersProfilePage;
  final UserEntity user;
  const ProfileFollowersTabListViewButtonMyFollower({
    super.key,
    required this.user,
    required this.isCurrentUsersProfilePage,
  });

  @override
  Widget build(BuildContext context) {
    if (isCurrentUsersProfilePage &&
        user.otherUserRelationToMyUser?.statusOnRelatedUser == "follower") {
      return InkWell(
        onTap: () {
          BlocProvider.of<ProfilePageCubit>(context).deleteFollower(
            userId: user.id,
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
            child: Center(
              child: Text(
                "Entfernen",
                style: Theme.of(context)
                    .textTheme
                    .labelMedium
                    ?.apply(color: Colors.white),
              ),
            ),
          ),
        ),
      );
    } else {
      return FollowButton(
        user: user,
        onTap: () {
          BlocProvider.of<ProfilePageCubit>(context)
              .followOrUnfollowCurrentProfileUserViaApi();
        },
      );
    }
  }
}
