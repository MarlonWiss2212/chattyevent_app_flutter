import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app_flutter/application/bloc/chat/current_chat_cubit.dart';
import 'package:social_media_app_flutter/core/dto/groupchat/update_groupchat_dto.dart';
import 'package:social_media_app_flutter/presentation/widgets/general/bottom_sheet/image_picker_list.dart';
import 'package:social_media_app_flutter/presentation/widgets/general/dialog/accept_decline_dialog.dart';

class ChatInfoPageProfileImage extends StatelessWidget {
  const ChatInfoPageProfileImage({super.key});

  Future<void> _onTapSetImageFunction(BuildContext context) async {
    await showModalBottomSheet(
      context: context,
      builder: (
        context,
      ) {
        return ImagePickerList(
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
                  onYesPress: () => BlocProvider.of<CurrentChatCubit>(context)
                      .updateCurrentGroupchatViaApi(
                        updateGroupchatDto: UpdateGroupchatDto(
                          updateProfileImage: newImage,
                        ),
                      )
                      .then(
                        (value) => Navigator.of(context).pop(),
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
    return BlocBuilder<CurrentChatCubit, CurrentChatState>(
      buildWhen: (previous, current) =>
          previous.currentChat.profileImageLink !=
          current.currentChat.profileImageLink,
      builder: (context, state) {
        return InkWell(
          borderRadius: const BorderRadius.all(
            Radius.circular(8.0),
          ),
          onTap: state.getCurrentGroupchatUser()?.admin == true
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