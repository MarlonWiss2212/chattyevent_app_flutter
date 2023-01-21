import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:social_media_app_flutter/application/bloc/auth/auth_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/user/user_cubit.dart';
import 'package:social_media_app_flutter/domain/entities/user_entity.dart';
import 'package:social_media_app_flutter/presentation/widgets/circle_image/cirlce_image.dart';

class MiniProfileImage extends StatelessWidget {
  const MiniProfileImage({super.key});

  @override
  Widget build(BuildContext context) {
    final currentUserId = Jwt.parseJwt(
        (BlocProvider.of<AuthCubit>(context).state as AuthLoaded).token)["sub"];

    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        UserEntity? foundUser = BlocProvider.of<UserCubit>(context).getUserById(
          userId: currentUserId,
        );

        return CircleImage(
          height: 24,
          width: 24,
          imageLink: foundUser?.profileImageLink,
        );
      },
    );
  }
}
