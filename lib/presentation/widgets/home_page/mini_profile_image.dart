import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app_flutter/application/bloc/home_page/home_profile_page/home_profile_page_cubit.dart';
import 'package:social_media_app_flutter/presentation/widgets/circle_image/cirlce_image.dart';

class MiniProfileImage extends StatelessWidget {
  const MiniProfileImage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeProfilePageCubit, HomeProfilePageState>(
      builder: (context, state) {
        return CircleImage(
          height: 24,
          width: 24,
          imageLink: state is HomeProfilePageWithUser
              ? state.user.profileImageLink
              : null,
        );
      },
    );
  }
}
