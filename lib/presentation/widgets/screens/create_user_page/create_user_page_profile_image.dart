import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app_flutter/application/bloc/auth/add_current_user_cubit.dart';
import 'package:social_media_app_flutter/presentation/widgets/circle_image/select_circle_image.dart';

class CreateUserPageProfileImage extends StatelessWidget {
  const CreateUserPageProfileImage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddCurrentUserCubit, AddCurrentUserState>(
      buildWhen: (previous, current) =>
          previous.profileImage?.path != current.profileImage?.path,
      builder: (context, state) {
        return SelectCircleImage(
          imageChanged: (newImage) {
            BlocProvider.of<AddCurrentUserCubit>(context).emitState(
              profileImage: newImage,
            );
          },
          image: state.profileImage,
        );
      },
    );
  }
}
