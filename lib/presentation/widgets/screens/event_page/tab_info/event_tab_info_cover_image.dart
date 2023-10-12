import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletons/skeletons.dart';
import 'package:chattyevent_app_flutter/application/bloc/current_event/current_event_cubit.dart';
import 'package:chattyevent_app_flutter/infastructure/dto/event/update_event_dto.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/dialog/image_picker_dialog.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/dialog/accept_decline_dialog.dart';

class EventTabInfoCoverImage extends StatelessWidget {
  const EventTabInfoCoverImage({super.key});

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
                    title: "general.notificationAlert.deleteImageText".tr(),
                    message:
                        "eventPage.tabs.infoTab.coverImageButton.deleteCoverImageDescription"
                            .tr(),
                    onNoPress: () {
                      Navigator.of(c).pop();
                      Navigator.of(context1).pop();
                    },
                    onYesPress: () {
                      BlocProvider.of<CurrentEventCubit>(context)
                          .updateCurrentEvent(
                        updateEventDto: UpdateEventDto(
                          removeCoverImage: true,
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
                    title: "general.notificationAlert.saveImageText".tr(),
                    message:
                        "eventPage.tabs.infoTab.coverImageButton.saveCoverImageDescription"
                            .tr(),
                    onNoPress: () {
                      Navigator.of(c).pop();
                      Navigator.of(context1).pop();
                    },
                    onYesPress: () {
                      BlocProvider.of<CurrentEventCubit>(context)
                          .updateCurrentEvent(
                        updateEventDto: UpdateEventDto(
                          updateCoverImage: newImage,
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
    final size = MediaQuery.of(context).size;

    return BlocBuilder<CurrentEventCubit, CurrentEventState>(
      builder: (context, state) {
        return Container(
          decoration: const BoxDecoration(shape: BoxShape.circle),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: InkWell(
              onTap: state.currentUserAllowedWithPermission(
                      permissionCheckValue:
                          state.event.permissions?.changeCoverImage)
                  ? () => _onTapSetImageFunction(context)
                  : null,
              child: Builder(
                builder: (context) {
                  if (state.event.coverImageLink != null) {
                    return Hero(
                      tag: "${state.event.id} coverImage",
                      child: CachedNetworkImage(
                        imageUrl: state.event.coverImageLink!,
                        cacheKey: state.event.coverImageLink!.split("?")[0],
                        fit: BoxFit.fitWidth,
                      ),
                    );
                  } else if (state.event.coverImageLink == null &&
                      state.loadingEvent) {
                    return SkeletonAvatar(
                      style: SkeletonAvatarStyle(
                        width: size.width,
                        height: size.width / 4 * 3,
                      ),
                    );
                  } else {
                    return InkWell(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(8.0),
                      ),
                      onTap: () => _onTapSetImageFunction(context),
                      child: Ink(
                        width: size.width,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surface,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        height: (size.width / 4 * 3) - 16,
                        child: const Icon(Icons.add),
                      ),
                    );
                  }
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
