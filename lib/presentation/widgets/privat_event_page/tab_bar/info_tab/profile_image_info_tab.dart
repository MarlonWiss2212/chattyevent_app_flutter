import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';
import 'package:social_media_app_flutter/application/bloc/private_event/current_private_event_cubit.dart';

class ProfileImageWidgetInfoTab extends StatelessWidget {
  final CurrentPrivateEventState privateEventState;
  const ProfileImageWidgetInfoTab({super.key, required this.privateEventState});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    if (privateEventState.privateEvent.coverImageLink != null) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        decoration: const BoxDecoration(shape: BoxShape.circle),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Hero(
            tag: "${privateEventState.privateEvent.id} coverImage",
            child: Image.network(
              privateEventState.privateEvent.coverImageLink!,
              fit: BoxFit.fitWidth,
            ),
          ),
        ),
      );
    } else if (privateEventState.privateEvent.coverImageLink == null &&
        privateEventState.loadingPrivateEvent) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: SkeletonAvatar(
          style: SkeletonAvatarStyle(
            width: size.width,
            height: (size.width / 4 * 3) - 16,
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: SizedBox(
          width: size.width,
          height: (size.width / 4 * 3) - 16,
          child: Card(
            color: Theme.of(context).colorScheme.secondaryContainer,
          ),
        ),
      );
    }
  }
}
