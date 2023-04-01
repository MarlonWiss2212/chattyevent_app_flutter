import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app_flutter/application/bloc/user/profile_page_cubit.dart';
import 'package:social_media_app_flutter/presentation/widgets/general/circle_image/cirlce_image.dart';

class ProfilePageCircleImage extends StatelessWidget {
  const ProfilePageCircleImage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfilePageCubit, ProfilePageState>(
      buildWhen: (previous, current) =>
          previous.user.profileImageLink != current.user.profileImageLink,
      builder: (context, state) {
        return CircleImage(
          imageLink: state.user.profileImageLink,
          heroTag: "${state.user.id} profileImage",
        );
      },
    );
  }
}
