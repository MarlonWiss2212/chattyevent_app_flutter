import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletons/skeletons.dart';
import 'package:social_media_app_flutter/application/bloc/private_event/current_private_event_cubit.dart';

class PrivateEventTabInfoCoverImage extends StatelessWidget {
  const PrivateEventTabInfoCoverImage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BlocBuilder<CurrentPrivateEventCubit, CurrentPrivateEventState>(
      buildWhen: (previous, current) =>
          previous.privateEvent.coverImageLink !=
          current.privateEvent.coverImageLink,
      builder: (context, state) {
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
              color: Theme.of(context).colorScheme.secondaryContainer,
            ),
          );
        }
      },
    );
  }
}
