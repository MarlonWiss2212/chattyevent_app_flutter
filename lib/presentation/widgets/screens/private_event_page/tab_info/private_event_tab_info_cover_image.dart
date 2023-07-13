import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletons/skeletons.dart';
import 'package:chattyevent_app_flutter/application/bloc/current_private_event/current_private_event_cubit.dart';
import 'package:chattyevent_app_flutter/infastructure/dto/private_event/update_private_event_dto.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/dialog/image_picker_dialog.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/dialog/accept_decline_dialog.dart';

class PrivateEventTabInfoCoverImage extends StatelessWidget {
  const PrivateEventTabInfoCoverImage({super.key});

  Future<void> _onTapSetImageFunction(BuildContext context) async {
    await showAnimatedDialog(
      curve: Curves.fastOutSlowIn,
      animationType: DialogTransitionType.slideFromBottomFade,
      context: context,
      builder: (context) {
        return ImagePickerDialog(
          ratioX: 4,
          ratioY: 3,
          imageChanged: (newImage) async {
            await showDialog(
              context: context,
              builder: (c) {
                return AcceptDeclineDialog(
                  title: "Bild speichern",
                  message: "Möchtest du das Bild als Cover Bild nehmen",
                  onNoPress: () => Navigator.of(c).pop(),
                  onYesPress: () {
                    BlocProvider.of<CurrentPrivateEventCubit>(context)
                        .updateCurrentPrivateEvent(
                          updatePrivateEventDto: UpdatePrivateEventDto(
                            updateCoverImage: newImage,
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
    final size = MediaQuery.of(context).size;

    return BlocBuilder<CurrentPrivateEventCubit, CurrentPrivateEventState>(
      builder: (context, state) {
        return InkWell(
          onTap: state.currentUserAllowedWithPermission(
                  permissionCheckValue:
                      state.privateEvent.permissions?.changeCoverImage)
              ? () => _onTapSetImageFunction(context)
              : null,
          child: Builder(
            builder: (context) {
              if (state.privateEvent.coverImageLink != null) {
                return Hero(
                  tag: "${state.privateEvent.id} coverImage",
                  child: Image.network(
                    state.privateEvent.coverImageLink!,
                    fit: BoxFit.fitWidth,
                  ),
                );
              } else if (state.privateEvent.coverImageLink == null &&
                  state.loadingPrivateEvent) {
                return SkeletonAvatar(
                  style: SkeletonAvatarStyle(
                    width: size.width,
                    height: size.width / 4 * 3,
                  ),
                );
              } else {
                return SizedBox(
                  child: Card(
                    color: Theme.of(context).colorScheme.surface,
                  ),
                );
              }
            },
          ),
        );
      },
    );
  }
}
