import 'package:chattyevent_app_flutter/core/enums/user_relation/user_relation_status_enum.dart';
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
            previous.user.myUserRelationToOtherUser?.status !=
            current.user.myUserRelationToOtherUser?.status,
        builder: (context, state) {
          return FollowButton(
            user: state.user,
            onTap: (UserRelationStatusEnum? value) {
              BlocProvider.of<ProfilePageCubit>(context)
                  .createUpdateUserOrDeleteCurrentProfileUserRelationViaApi(
                value: value,
              );
            },
          );
        },
      ),
    );
  }
}
