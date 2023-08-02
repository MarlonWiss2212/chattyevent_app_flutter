import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chattyevent_app_flutter/application/bloc/current_groupchat/current_chat_cubit.dart';
import 'package:chattyevent_app_flutter/infastructure/dto/groupchat/update_groupchat_dto.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/dialog/image_picker_dialog.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/dialog/accept_decline_dialog.dart';

class ChatInfoPageProfileImage extends StatelessWidget {
  const ChatInfoPageProfileImage({super.key});

  Future<void> _onTapSetImageFunction(BuildContext context) async {
    await showAnimatedDialog(
      curve: Curves.fastOutSlowIn,
      animationType: DialogTransitionType.slideFromBottomFade,
      context: context,
      builder: (
        context,
      ) {
        return ImagePickerDialog(
          ratioX: 4,
          ratioY: 3,
          imageChanged: (newImage) async {
            await showDialog(
              context: context,
              builder: (c) {
                return AcceptDeclineDialog(
                  title: "Bild speichern",
                  message: "Möchtest du das Bild als Gruppenchat Bild nehmen",
                  onNoPress: () => Navigator.of(c).pop(),
                  onYesPress: () =>
                      BlocProvider.of<CurrentGroupchatCubit>(context)
                          .updateCurrentGroupchatViaApi(
                            updateGroupchatDto: UpdateGroupchatDto(
                              updateProfileImage: newImage,
                            ),
                          )
                          .then(
                            (value) => Navigator.of(c).pop(),
                          ),
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
              : Image.network(
                  state.currentChat.profileImageLink!,
                  fit: BoxFit.cover,
                ),
        );
      },
    );
  }
}


//