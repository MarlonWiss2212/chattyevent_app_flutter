import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chattyevent_app_flutter/application/bloc/auth/auth_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/profile_page/profile_page_cubit.dart';
import 'package:chattyevent_app_flutter/infastructure/dto/user/update_user_dto.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/dialog/image_picker_dialog.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/circle_image/cirlce_image.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/dialog/accept_decline_dialog.dart';

class ProfilePageCircleImage extends StatelessWidget {
  const ProfilePageCircleImage({super.key});

  Future<void> _onTapSetImageFunction(BuildContext context) async {
    await showAnimatedDialog(
      curve: Curves.fastOutSlowIn,
      animationType: DialogTransitionType.slideFromBottomFade,
      context: context,
      builder: (context1) {
        return ImagePickerDialog(
          ratioX: 1,
          ratioY: 1,
          removeImageOption: true,
          imageChanged: (newImage) async {
            if (newImage == null) {
              await showDialog(
                context: context1,
                builder: (c) {
                  return AcceptDeclineDialog(
                    title: "general.notificationAlert.deleteImageText".tr(),
                    message:
                        "profilePage.profileImageButton.deleteProfileImageDescription"
                            .tr(),
                    onNoPress: () {
                      Navigator.of(c).pop();
                      Navigator.of(context1).pop();
                    },
                    onYesPress: () {
                      BlocProvider.of<ProfilePageCubit>(context)
                          .deleteProfileImage()
                          .then(
                        (value) {
                          Navigator.of(c).pop();
                          Navigator.of(context1).pop();
                        },
                      );
                    },
                  );
                },
              );
            } else {
              await showDialog(
                context: context1,
                builder: (c) {
                  return AcceptDeclineDialog(
                    title: "general.notificationAlert.saveImageText".tr(),
                    message:
                        "profilePage.profileImageButton.saveProfileImageDescription"
                            .tr(),
                    onNoPress: () {
                      Navigator.of(c).pop();
                      Navigator.of(context1).pop();
                    },
                    onYesPress: () {
                      BlocProvider.of<ProfilePageCubit>(context)
                          .updateUser(
                        updateUserDto: UpdateUserDto(
                          updateProfileImage: newImage,
                        ),
                      )
                          .then(
                        (value) {
                          Navigator.of(c).pop();
                          Navigator.of(context1).pop();
                        },
                      );
                    },
                  );
                },
              );
            }
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfilePageCubit, ProfilePageState>(
      buildWhen: (p, c) => p.user.profileImageLink != c.user.profileImageLink,
      builder: (context, state) {
        return CircleImage(
          imageLink: state.user.profileImageLink,
          heroTag: "${state.user.id} profileImage",
          onTap: state.user.id ==
                  BlocProvider.of<AuthCubit>(context).state.currentUser.id
              ? () => _onTapSetImageFunction(context)
              : null,
        );
      },
    );
  }
}
