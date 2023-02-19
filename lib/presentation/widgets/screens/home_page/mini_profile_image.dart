import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app_flutter/application/bloc/auth/current_user_cubit.dart';
import 'package:social_media_app_flutter/presentation/widgets/circle_image/cirlce_image.dart';

class MiniProfileImage extends StatelessWidget {
  const MiniProfileImage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrentUserCubit, CurrentUserState>(
      builder: (context, state) {
        return CircleImage(
          height: 24,
          width: 24,
          imageLink: state.user.profileImageLink,
        );
      },
    );
  }
}