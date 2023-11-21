import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chattyevent_app_flutter/application/bloc/current_groupchat/current_chat_cubit.dart';
import 'package:chattyevent_app_flutter/infrastructure/dto/groupchat/update_groupchat_dto.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/dialog/image_picker_dialog.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/dialog/accept_decline_dialog.dart';

class ChatInfoPageProfileImage extends StatelessWidget {
  const ChatInfoPageProfileImage({super.key});

  Future<void> _onTapSetImageFunction(BuildContext context) async {
    await showAnimatedDialog(
      curve: Curves.fastOutSlowIn,
      animationType: DialogTransitionType.slideFromBottomFade,
      context: context,
      builder: (context1) {
        return ImagePickerDialog(
          ratioX: 4,
          ratioY: 3,
          removeImageOption: true,
          imageChanged: (newImage) async {
            if (newImage == null) {
              await showDialog(
                context: context1,
                builder: (c) {
                  return AcceptDeclineDialog(
                    title: "general.deleteImageText".tr(),
                    message:
                        "groupchatPage.infoPage.profileImageButton.deleteProfileImageDescription"
                            .tr(),
                    onNoPress: () {
                      Navigator.of(c).pop();
                      Navigator.of(context1).pop();
                    },
                    onYesPress: () {
                      BlocProvider.of<CurrentGroupchatCubit>(context)
                          .updateCurrentGroupchatViaApi(
                        updateGroupchatDto: UpdateGroupchatDto(
                          removeProfileImage: true,
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
            } else {
              await showDialog(
                context: context1,
                builder: (c) {
                  return AcceptDeclineDialog(
                    title: "general.saveImageText".tr(),
                    message:
                        "groupchatPage.infoPage.profileImageButton.saveProfileImageDescription"
                            .tr(),
                    onNoPress: () {
                      Navigator.of(c).pop();
                      Navigator.of(context1).pop();
                    },
                    onYesPress: () {
                      BlocProvider.of<CurrentGroupchatCubit>(context)
                          .updateCurrentGroupchatViaApi(
                        updateGroupchatDto: UpdateGroupchatDto(
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
    Color color = const Color(0xCC000000);
    if (MediaQuery.of(context).platformBrightness == Brightness.light) {
      color = const Color.fromARGB(204, 255, 255, 255);
    }
    return BlocBuilder<CurrentGroupchatCubit, CurrentGroupchatState>(
      buildWhen: (p, c) =>
          p.currentChat.profileImageLink != c.currentChat.profileImageLink,
      builder: (context, state) {
        return InkWell(
          borderRadius: const BorderRadius.all(
            Radius.circular(8.0),
          ),
          onTap: state.currentUserAllowedWithPermission(
            permissionCheckValue:
                state.currentChat.permissions?.changeProfileImage,
          )
              ? () => _onTapSetImageFunction(context)
              : null,
          child: state.currentChat.profileImageLink == null
              ? const SizedBox()
              : Stack(
                  fit: StackFit.expand,
                  children: [
                    CachedNetworkImage(
                      imageUrl: state.currentChat.profileImageLink!,
                      cacheKey:
                          state.currentChat.profileImageLink!.split("?")[0],
                      fit: BoxFit.cover,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            color,
                            const Color(0x00000000),
                            const Color(0x00000000),
                            color
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
        );
      },
    );
  }
}
