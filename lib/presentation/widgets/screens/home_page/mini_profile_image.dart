import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app_flutter/application/bloc/auth/auth_cubit.dart';
import 'package:social_media_app_flutter/presentation/widgets/general/circle_image/cirlce_image.dart';

class MiniProfileImage extends StatelessWidget {
  const MiniProfileImage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      buildWhen: (previous, current) =>
          previous.currentUser.profileImageLink !=
          current.currentUser.profileImageLink,
      builder: (context, state) {
        return CircleImage(
          height: 24,
          width: 24,
          imageLink: state.currentUser.profileImageLink,
        );
      },
    );
  }
}
