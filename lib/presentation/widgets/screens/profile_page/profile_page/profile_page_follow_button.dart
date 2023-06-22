import 'package:chattyevent_app_flutter/presentation/widgets/general/follow_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chattyevent_app_flutter/application/bloc/profile_page/profile_page_cubit.dart';

class ProfilePageFollowButton extends StatelessWidget {
  const ProfilePageFollowButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocBuilder<ProfilePageCubit, ProfilePageState>(
        buildWhen: (previous, current) =>
            previous.user.myUserRelationToOtherUser?.statusOnRelatedUser !=
            current.user.myUserRelationToOtherUser?.statusOnRelatedUser,
        builder: (context, state) {
          return FollowButton(
            user: state.user,
            onTap: () {
              BlocProvider.of<ProfilePageCubit>(context)
                  .followOrUnfollowCurrentProfileUserViaApi();
            },
          );
        },
      ),
    );
  }
}
