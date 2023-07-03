import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chattyevent_app_flutter/application/bloc/auth/auth_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/profile_page/profile_page_cubit.dart';
import 'package:chattyevent_app_flutter/infastructure/dto/user/update_user_dto.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/bottom_sheet/image_picker_list.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/circle_image/cirlce_image.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/dialog/accept_decline_dialog.dart';

class ProfilePageCircleImage extends StatelessWidget {
  const ProfilePageCircleImage({super.key});

  Future<void> _onTapSetImageFunction(BuildContext context) async {
    await showModalBottomSheet(
      context: context,
      builder: (context) {
        return ImagePickerList(
          ratioX: 1,
          ratioY: 1,
          imageChanged: (newImage) async {
            await showDialog(
              context: context,
              builder: (c) {
                return AcceptDeclineDialog(
                  title: "Bild speichern",
                  message: "Möchtest du das Bild als Profilbild nehmen",
                  onNoPress: () => Navigator.of(c).pop(),
                  onYesPress: () {
                    BlocProvider.of<ProfilePageCubit>(context)
                        .updateUser(
                          updateUserDto: UpdateUserDto(
                            updateProfileImage: newImage,
                          ),
                        )
                        .then(
                          (value) => Navigator.of(c).pop(),
                        );
                  },
                );
              },
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, authState) {
        return BlocBuilder<ProfilePageCubit, ProfilePageState>(
          builder: (context, state) {
            return CircleImage(
              imageLink: state.user.profileImageLink,
              heroTag: "${state.user.id} profileImage",
              onTap: state.user.id == authState.currentUser.id
                  ? () => _onTapSetImageFunction(context)
                  : null,
            );
          },
        );
      },
    );
  }
}
