import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app_flutter/application/bloc/auth/auth_cubit.dart';
import 'package:social_media_app_flutter/presentation/widgets/circle_image/cirlce_image.dart';

class MiniProfileImage extends StatelessWidget {
  const MiniProfileImage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(builder: (context, state) {
      state = state as AuthLoaded;

      return CircleImage(
        height: 24,
        width: 24,
        imageLink: state.userAndToken.user.profileImageLink,
      );
    });
  }
}
