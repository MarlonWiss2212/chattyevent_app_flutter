import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app_flutter/application/bloc/user/profile_page_cubit.dart';
import 'package:social_media_app_flutter/presentation/widgets/general/follow_button.dart';

class ProfilePageFollowButton extends StatelessWidget {
  const ProfilePageFollowButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfilePageCubit, ProfilePageState>(
      buildWhen: (previous, current) =>
          previous.user.myUserRelationToOtherUser?.statusOnRelatedUser !=
          current.user.myUserRelationToOtherUser?.statusOnRelatedUser,
      builder: (context, state) {
        return FollowButton(
          user: state.user,
          onTap: () {
            BlocProvider.of<ProfilePageCubit>(context)
                .followOrUnfollowUserViaApi();
          },
        );
      },
    );
  }
}
